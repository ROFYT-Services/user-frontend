import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  SignInViewModel? provider;
  OtpFieldController otpController = OtpFieldController();
  int time = 45;
  bool isResend = true;
  String otpText = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    timingView();
    provider = Provider.of<SignInViewModel>(context, listen: false);
  }

  changeReSendText() {
    setState(() {
      isResend = !isResend;
    });
  }

  timingView() async {
    changeReSendText();
    for (int i = 45; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1), () {
        debugPrint("Ticking");
        setState(() {
          time = i;
        });
      });
    }
    changeReSendText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(36, 46, 66, 1),
          shadowColor: Color.fromRGBO(244, 67, 54, 0)),
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Column(
            children: [
              Container(
                width: AppSceenSize.getWidth(context) * 1,
                height: AppSceenSize.getHeight(context) * 0.20,
                color: Color.fromRGBO(36, 46, 66, 1),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Phone Verification",
                          style: AppTextStyle.phoneverifytext),
                      SizedBox(height: 10),
                      Text("Enter your OTP code here",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Center(
                    child: OTPTextField(
                        controller: otpController,
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: 60,
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 10,
                        style: TextStyle(fontSize: 17),
                        onChanged: (pin) {
                          print("Changed: " + pin);
                          otpText = pin;
                        },
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          otpText = pin;
                        }),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Verify your OTP within   $time Sec.",
                    style: TextStyle(fontSize: 18),
                  ),
                  isResend
                      ? Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              provider!.loginCustomer(context);
                              timingView();
                            },
                            child: Text(
                              "RESEND",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  isLoading
                      ? AppSceenSize.loadingIcon
                      : Container(
                          width: AppSceenSize.getWidth(context) * 0.90,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColor.btncoloryellow),
                            ),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await provider!.loginOtpVerificationCustomer(
                                  context, otpText);

                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Verify Now')],
                            ),
                          ),
                        ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
