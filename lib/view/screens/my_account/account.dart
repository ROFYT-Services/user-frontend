import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/customer_model.dart';
import 'package:uber_pro_kolkata/services/api_services.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String selectedDate = "";
  String phoneNumber = "";
  bool isLoading = false;
  String url = "";
  String selectedGender = "Male";
  List<String> genderOptions = ['Male', 'Female', 'Other'];
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    CustomerProfile _provider =
        Provider.of<CustomerProfile>(context, listen: false);
    await _provider.getProfile(context);
    CustomerProfileModel customer = _provider.currCustomerProfile!;
    debugPrint("${customer.firstName} ${customer.email}");
    setState(() {
      nameController.text = customer.firstName + " " + customer.lastName;
      emailController.text = customer.email;
      selectedGender = customer.gender;
      phoneNumber = customer.phone;
      url = customer.photoUpload;
      selectedDate = customer.birthDay;
    });
    if (selectedGender.isEmpty) selectedGender = "Male";
  }

  uploadFile(File f) async {
    setState(() {
      isLoading = true;
    });
    FormData formdata =
        FormData.fromMap({"file": await MultipartFile.fromFile(f.path)});
    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] = "Token ${SignInViewModel.token}";
    var response = await dio.post(
      "${NetworkApiService.baseUrl}/account/upload/",
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        print("$sent Bytes of $total Bytes - $percentage % uploaded");
      },
    );
    if (response.statusCode == 200) {
      context.showSnackBar(message: "File Uploaded");
    } else {
      context.showSnackBar(
          message: "Error during connection to server, try again!");
    }
    setState(() {
      isLoading = false;
      url = response.data['url'];
    });
    Map<String, dynamic> map = {"photo_upload": url};
    CustomerProfile _provider =
        Provider.of<CustomerProfile>(context, listen: false);
    await _provider.updateProfile(context, map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: AppColor.AppThemecolor,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Account",
                      style: AppTextStyle.notificationsText,
                    ),
                    isLoading
                        ? AppSceenSize.loadingIcon
                        : GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();
                              if (result != null) {
                                File file =
                                    File(result.files.single.path.toString());
                                uploadFile(file);
                              }
                            },
                            child: showImage(url)),
                  ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Card(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 15, horizontal: 10),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Level',
                  //           style: AppTextStyle.myaccounttext,
                  //         ),
                  //         Spacer(),
                  //         Text('Gold Member'),
                  //         Icon(Icons.arrow_right)
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: Colors.white70,
                    child: Column(
                      children: [
                        _buildAccountSectionCard(
                          title: "Name",
                          subtitle: "Aly Khan",
                          controller: nameController,
                        ),
                        Container(
                          width: AppSceenSize.getWidth(context),
                          height: 1,
                          color: Colors.black26,
                        ),
                        _buildAccountSectionCard(
                          title: "Email",
                          subtitle: "",
                          controller: emailController,
                        ),
                        Container(
                          width: AppSceenSize.getWidth(context),
                          height: 1,
                          color: Colors.black26,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Gender",
                                style: AppTextStyle.myaccounttext,
                              ),
                              DropdownButton<String>(
                                value: selectedGender,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedGender = newValue!;
                                  });
                                },
                                items: genderOptions.map((gender) {
                                  return DropdownMenuItem<String>(
                                    value: gender,
                                    child: Text(
                                      gender,
                                      style: AppTextStyle.drawerusertext,
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        // _buildAccountSectionCard(
                        //   title: "Gender",
                        //   subtitle: "Male",
                        //   controller: genderController,
                        // ),
                        Container(
                          width: AppSceenSize.getWidth(context),
                          height: 1,
                          color: Colors.black26,
                        ),
                        _buildAccountSectionCard(
                          title: "Birthday",
                          subtitle: selectedDate,
                          controller: null,
                        ),
                        Container(
                          width: AppSceenSize.getWidth(context),
                          height: 1,
                          color: Colors.black26,
                        ),
                        _buildAccountSectionCard(
                            title: "Phone number",
                            subtitle: phoneNumber,
                            controller: null),
                        Container(
                          width: AppSceenSize.getWidth(context),
                          height: 1,
                          color: Colors.black26,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        isLoading
                            ? AppSceenSize.loadingIcon
                            : Container(
                                width: AppSceenSize.getWidth(context) * 0.90,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            AppColor.btncoloryellow),
                                  ),
                                  onPressed: () async {
                                    if (selectedDate.isEmpty) {
                                      context.showErrorSnackBar(
                                          message: "Please fill birth-date");
                                      return;
                                    }
                                    setState(() {
                                      isLoading = true;
                                    });
                                    Map<String, dynamic> body = {
                                      "first_name": nameController.text,
                                      "email": emailController.text,
                                      'birth_day': selectedDate,
                                      'gender': selectedGender,
                                    };
                                    await CustomerProfile()
                                        .updateProfile(context, body);
                                    setState(() {
                                      isLoading = false;
                                    });

                                    Navigator.of(context).pop();
                                  },
                                  child: Text('SAVE'),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildAccountSectionCard({
    required String title,
    required String subtitle,
    required TextEditingController? controller,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (title == "Birthday") {
          _selectDate(context);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.myaccounttext,
            ),
            Spacer(),
            (title == "Birthday" || title == "Phone number")
                ? Text(
                    subtitle,
                    style: AppTextStyle.drawerusertext,
                  )
                : SizedBox(
                    width: AppSceenSize.getWidth(context) * 0.5,
                    child: TextField(
                      controller: controller,
                      style: AppTextStyle.drawerusertext,
                    ),
                  )
            // Icon(
            //   Icons.arrow_right,
            //   color: Color(0xFFC8C7CC),
            // )
          ],
        ),
      ),
    );
  }
}
