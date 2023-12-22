import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: Column(
        children: [
          Container(
            width: AppSceenSize.getWidth(context),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: AppColor.AppThemecolor,
            child: Text(
              "Settings",
              style: AppTextStyle.notificationsText,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/icons/Avatar.png",
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Level',
                              style: AppTextStyle.myaccounttext,
                            ),
                            Text('Gold Member'),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _buildSettingCard("Notification"),
                _buildSettingCard("Security"),
                _buildSettingCard("Language"),
                _buildSettingCard("Clear cache"),
                _buildSettingCard("Term & Privacy Policy"),
                _buildSettingCard("Contact us"),
                SizedBox(
                  height: 20,
                ),
                _buildLogout("Log out")
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildSettingCard(String title) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: AppTextStyle.myaccounttext,
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 15,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  _buildLogout(String title) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 50,
      color: Colors.grey.withOpacity(0.2),
      child: Center(
        child: Text(
          title,
          style: AppTextStyle.myaccounttext,
        ),
      ),
    );
  }
}
