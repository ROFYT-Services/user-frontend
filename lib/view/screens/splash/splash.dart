import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/services/location_service.dart';
import 'package:uber_pro_kolkata/view/screens/home/home.dart';
import 'package:uber_pro_kolkata/view/screens/onboarding/onboarding.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../../../constant/app_asset_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    // String token = '1b94acf007252dea50d7e19e4ada5d517bca732e';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString("token", token);
    if (sharedPreferences.containsKey('token')) {
      SignInViewModel.token = sharedPreferences.getString('token') ?? "";
      await LocationServices().checkPermissions();
      Position position = await LocationServices().currentLocation();
      CustomerProfile _provider =
          Provider.of<CustomerProfile>(context, listen: false);
      await _provider.getProfile(context);

      // changeLoading();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(startingPosition: position),
          ));
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.AppThemecolor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 25,
            ),
            Image.asset(
              AppAssetImage.topImage,
              width: AppSceenSize.getWidth(context),
              fit: BoxFit.cover,
            ),
            Image.asset(
              AppAssetImage.bottomImage,
              width: AppSceenSize.getWidth(context),
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
