import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dataList = [
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/shape.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/min.png',
      },
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/min.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/shape.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/min.png',
      },
      {
        'notificationHeading': 'System',
        'subtext': 'Your booking #1234 has been suc...',
        'imageUrl': 'assets/icons/min.png',
      },
      {
        'notificationHeading': 'Promotion',
        'subtext': 'Invite friends - Get 3 coupons each!',
        'imageUrl': 'assets/icons/promo.png',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.AppThemecolor,
        shadowColor: Color.fromARGB(0, 0, 0, 0),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: AppColor.AppThemecolor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: AppTextStyle.notificationsText,
                ),
                Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.black),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];
                return Card(
                  child: ListTile(
                    leading: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6.0,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                            backgroundColor: Color(0xFFF1F1F1),
                            child: Image.asset(item['imageUrl'].toString()))),
                    title: Text(item['notificationHeading'].toString()),
                    subtitle: Text(item['subtext'].toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
