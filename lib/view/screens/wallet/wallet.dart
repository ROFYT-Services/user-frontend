import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/screens/wallet/component/payment.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
                Text(
                  "My Wallet",
                  style: AppTextStyle.notificationsText,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/coin.png',
                      width: 60,
                    ),
                    Text(
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

          //build coupon list
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
          top: 160,
          left: AppSceenSize.getWidth(context) * 0.15,
          child: Container(
            width: AppSceenSize.getWidth(context) * 0.7,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 170,
          left: AppSceenSize.getWidth(context) * 0.1,
          child: Container(
            width: AppSceenSize.getWidth(context) * 0.8,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 190,
          left: AppSceenSize.getWidth(context) * 0.05,
          child: Container(
            width: AppSceenSize.getWidth(context) * 0.9,
            height: 200,
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
                    SizedBox(
                      width: 20,
                      height: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
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
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Balance",
                          style: TextStyle(color: Color(0xFFC8C7CC))),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "2000",
                        style: AppTextStyle.onboaringSubtitle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: AppSceenSize.getHeight(context) * 0.5,
            child: _builPaymentCoupon())
      ],
    );
  }

  _builPaymentCoupon() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PaymentScreen();
            }));
          },
          child: Container(
            height: 50,
            width: AppSceenSize.getWidth(context),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Payment Methods",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 20,
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: AppSceenSize.getWidth(context),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Coupon",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text("3", style: TextStyle(color: Color(0xFFC8C7CC))),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 50,
          width: AppSceenSize.getWidth(context),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Integral mall",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text("4500", style: TextStyle(color: Color(0xFFC8C7CC))),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
