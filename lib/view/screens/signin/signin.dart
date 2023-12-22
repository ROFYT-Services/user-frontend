import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../../../constant/app_asset_image.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  SignInViewModel? _provider;
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _provider = Provider.of<SignInViewModel>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              AppAssetImage.headerbg,
              width: AppSceenSize.getWidth(context),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: 80,
            left: 50,
            child: Container(
              child: Row(
                children: [
                  Image.asset(
                    AppAssetImage.logotype,
                    width: 40,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "MY RIDE",
                    style: AppTextStyle.headingText,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppSceenSize.getHeight(context) * 0.3,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              height: AppSceenSize.getHeight(context) * 0.4,
              width: AppSceenSize.getWidth(context) * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(blurRadius: 10.0, color: Colors.grey)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: _buildSignInTabContent(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text("ENTER YOUR MOBILE NUMBER "),
        SizedBox(height: 20),
        IntlPhoneField(
          controller: _provider!.mobileNumberController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ), // Customize the border color here
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          initialCountryCode: 'IN',
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Referral Code",
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade200,
              ), // Customize the border color here
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        isLoading
            ? AppSceenSize.loadingIcon
            : Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColor.btncoloryellow,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await _provider!.registerCustomer(context, controller.text);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Text('Next'),
                ),
              ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
