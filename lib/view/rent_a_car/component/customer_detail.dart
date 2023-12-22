import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final _title = TextStyle(color: Color(0xFF333333));
  final _content = TextStyle(color: Color(0xFF666666));
  final _uploadTitle = TextStyle(color: Color(0xFF999999));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeadingSection(),
              _buildProfileFormSection(),
              _buildButtonSection(),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeadingSection() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back),
                Text("Customer Details"),
                SizedBox()
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Image.asset("assets/icons/profileuser.png"),
        const Text(
          "Mrinmay",
          style: AppTextStyle.coupncodeText,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildProfileFormSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildfirst(),
          _buildFileuploadSection(),
        ],
      ),
    );
  }

  _buildfirst() {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "First Name",
                style: _title,
              ),
              Text(
                "Santosh",
                style: _content,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Color(0xFF666666),
          height: 0.5,
        ),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last Name",
                style: _title,
              ),
              Text(
                "Sharma",
                style: _content,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Color(0xFF666666),
          height: 0.5,
        ),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Full Address",
                style: _title,
              ),
              Text(
                "Gurgoan,haryana",
                style: _content,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Color(0xFF666666),
          height: 0.5,
        ),
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Alternate Phone no.",
                style: _title,
              ),
              Text(
                "7937783633",
                style: _content,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          color: Color(0xFF666666),
          height: 0.5,
        ),
      ],
    );
  }

  _buildFileuploadSection() {
    return Column(
      children: [
        //ADHAAR SECTION
        Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Adhar No*",
                    style: _title,
                  ),
                  Text(
                    "3462 6373 6476 3463",
                    style: _content,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFF666666),
              height: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'Adhar upload Front',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'Adhar upload Back',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          const Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        //PAN NO* SECTION
        Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Pan No*",
                    style: _title,
                  ),
                  Text(
                    "BSLDI7863",
                    style: _content,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFF666666),
              height: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'Pan upload',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),

        //License Section

        Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "License No*",
                    style: _title,
                  ),
                  Text(
                    "83627366236626",
                    style: _content,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFF666666),
              height: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'License front',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'License back',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff666666).withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/check_circle.png"),
                        Text(
                          'Customer photo',
                          style: _uploadTitle,
                        ),
                      ],
                    ),
                    Container(
                      height: 34,
                      width: AppSceenSize.getWidth(context) * 0.18,
                      decoration: BoxDecoration(
                          color: Color(0xFF00B74C),
                          border: Border.all(
                              color: const Color(0xff666666).withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        children: [
                          Image.asset('assets/icons/upload_file.png'),
                          Text(
                            "upload",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }

  _buildButtonSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xFFD7AF0F), // Text color
                minimumSize: const Size(
                  double.infinity - 50,
                  50,
                ), // Full width button
              ),
              child: const Text("upload Documents for approval")),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
