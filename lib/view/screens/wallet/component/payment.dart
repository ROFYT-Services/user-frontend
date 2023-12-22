import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: Stack(
        children: [
          Container(
            height: AppSceenSize.getHeight(context),
            width: AppSceenSize.getWidth(context),
            color: Colors.grey.withOpacity(0.1),
          ),
          Container(
            height: 240,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: AppColor.AppThemecolor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Payment Method",
                  style: AppTextStyle.notificationsText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/coin.png',
                      width: 60,
                    ),
                    const Text(
                      "2000",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    )
                  ],
                ),
              ],
            ),
          ),

          //Stack OF Money card
          _buildStack(),
        ],
      ),
    );
  }

  _buildStack() {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
        ),
        Positioned(
          top: AppSceenSize.getHeight(context) * 0.24,
          left: AppSceenSize.getWidth(context) * 0.05,
          child: Container(
            width: AppSceenSize.getWidth(context) * 0.9,
            height: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundColor: Color(0xFFF0C414),
                        radius: 26,
                        child: Image.asset("assets/icons/money.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Cash",
                          style: AppTextStyle.onboaringSubtitle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Default Payment Method",
                            style: TextStyle(color: Color(0xFFC8C7CC))),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: AppSceenSize.getHeight(context) * 0.4,
            left: AppSceenSize.getHeight(context) * 0.02,
            right: AppSceenSize.getHeight(context) * 0.02,
            child: _buildPaymentOption()),
        Positioned(
            top: AppSceenSize.getHeight(context) * 0.8,
            left: AppSceenSize.getHeight(context) * 0.02,
            right: AppSceenSize.getHeight(context) * 0.02,
            child: _buildAddCard())
      ],
    );
  }

  _buildPaymentOption() {
    return Card(
      child: SizedBox(
        height: 250,
        width: AppSceenSize.getWidth(context) * 0.6,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "CreditCard",
                style: AppTextStyle.onboaringSubtitle,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: AppSceenSize.getWidth(context) * 0.8,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/icons/visa.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("**************8764")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: AppSceenSize.getWidth(context) * 0.8,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/icons/paypal.png"),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text("**************8764")
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: AppSceenSize.getWidth(context) * 0.8,
                    decoration:
                        BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset("assets/icons/master_card.png"),
                          SizedBox(
                            width: 20,
                          ),
                          Text("**************8764")
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildAddCard() {
    return Container(
      height: 40,
      width: AppSceenSize.getWidth(context) * 0.8,
      decoration: BoxDecoration(
          color: Color(0xFF14BCF0), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Add New Method',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
