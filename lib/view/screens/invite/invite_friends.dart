import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/customer_model.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';

class InviteFriends extends StatefulWidget {
  const InviteFriends({super.key});

  @override
  State<InviteFriends> createState() => _InviteFriendsState();
}

class _InviteFriendsState extends State<InviteFriends> {
  String code = "";

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
    setState(() {
      code = customer.code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        title: Text("Invite Friends"),
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: Column(
        children: [
          Container(
            height: AppSceenSize.getHeight(context) * 0.50,
            color: AppColor.AppThemecolor,
            child: Image.asset(
              "assets/icons/gift.png",
              height: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Share Your Invite Code",
                  style: AppTextStyle.shareetext,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        code,
                        style: AppTextStyle.invitetext,
                      ),
                    ),
                    GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(ClipboardData(text: code));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Copied to clipboard'),
                          ));
                        },
                        child: Image.asset('assets/icons/share.png'))
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: AppSceenSize.getWidth(context),
                  decoration: BoxDecoration(color: Color(0xFF28B910)),
                  child: ElevatedButton(
                      onPressed: () {
                        Share.share(
                            'Refer your friends to get 30% off when your friends complete their first ride using your referral code ($code) and your friends also get 20% off on their first ride using your referral code.');
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => InviteFriendsList(),
                        //     ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFF28B910), // Set the background color to red
                        padding: EdgeInsets.symmetric(
                            vertical: 15), // Adjust the padding as needed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Optional: Add rounded corners
                        ),
                      ),
                      child: Text(
                        "Invite Friends",
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
