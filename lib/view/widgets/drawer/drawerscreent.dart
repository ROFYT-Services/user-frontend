import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/customer_model.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/view/screens/coupon_code/coupon_code_screen.dart';
import 'package:uber_pro_kolkata/view/screens/history/history.dart';
import 'package:uber_pro_kolkata/view/screens/invite/invite_friends.dart';
import 'package:uber_pro_kolkata/view/screens/my_account/account.dart';
import 'package:uber_pro_kolkata/view/screens/notifications/notifications.dart';
import 'package:uber_pro_kolkata/view/screens/splash/splash.dart';
import 'package:uber_pro_kolkata/view/screens/wallet/wallet.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

drawerScreen(BuildContext context) {
  CustomerProfile _provider =
      Provider.of<CustomerProfile>(context, listen: true);
  CustomerProfileModel customer = _provider.currCustomerProfile!;

  return ListView(
    children: [
      Container(
        height: AppSceenSize.getHeight(context) * 1,
        width: AppSceenSize.getWidth(context) * 0.25,
        child: Column(
          children: [
            Container(
              height: AppSceenSize.getHeight(context) * 0.33,
              width: AppSceenSize.getWidth(context) * 1,
              decoration: const BoxDecoration(color: AppColor.AppThemecolor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyAccount(),
                          ),
                        );
                      },
                      child: showImage(customer.photoUpload),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      customer.firstName,
                      style: AppTextStyle.drawerusername,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Wallet Balance"),
                          Spacer(),
                          Text(
                            "2000",
                            style: AppTextStyle.draweruserwallet,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Container(
                            margin: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Image.asset('assets/icons/wallet.png'),
              title: Text(
                "My Wallet",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WalletScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/history.png'),
              title: Text(
                "Your Ride",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/notification.png'),
              title: Text(
                "Notification",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationsPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/invite.png'),
              title: Text(
                "Invite Friends",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InviteFriends(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset('assets/icons/invite.png'),
              title: Text(
                "Coupons Codes",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CouponCodeScreen(),
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.star,
            //     color: Colors.black,
            //   ),
            //   title: const Text(
            //     "Rating",
            //     style: AppTextStyle.drawerusertext,
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => const RatingScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              leading: Image.asset('assets/icons/customer.png'),
              title: const Text(
                "Customer Support",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Image.asset('assets/icons/logout.png'),
              title: const Text(
                "Logout",
                style: AppTextStyle.drawerusertext,
              ),
              onTap: () => _showLogout(context),
            ),
          ],
        ),
      )
    ],
  );
}

//Logout Popup

void _showLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: const [
            Text('Do you want to log out'),
          ],
        ),
        // content: Text(
        //     'Your booking has been confirmed\n Driver will pickup you in 2 minutes.'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              if (sharedPreferences.containsKey('token')) {
                SignInViewModel.token = "";
                sharedPreferences.remove('token');
                Navigator.of(context).popUntil((route) => false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ),
                );
              }
            },
            child: const Text('YES'),
          ),
          TextButton(
            onPressed: () {
              // Perform an action here
              Navigator.of(context).pop();
            },
            child: Text('NO'),
          ),
        ],
      );
    },
  );
}
