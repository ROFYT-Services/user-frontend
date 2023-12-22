import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uber_pro_kolkata/repository/signin_repo.dart';
import 'package:uber_pro_kolkata/services/location_service.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view/screens/home/home.dart';
import 'package:uber_pro_kolkata/view/screens/onboarding/register_screen.dart';
import 'package:uber_pro_kolkata/view/screens/phoneverify/phoneverify.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';

class SignInViewModel extends ChangeNotifier {
  final _signInRepo = SignInRepo();

  bool loading = false;

  final _mobileNumberController = TextEditingController();

  // String phone = '9068616413';

  String phone = '';

  static String token = '';

  // static String token = '5a97fbd1c6f279fee5a9aa630e3a9ce236ef54df';

  get mobileNumberController => this._mobileNumberController;

  Future registerCustomer(BuildContext context, String referrer) async {
    if (_mobileNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Phone Number"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      loading = true;
      var bodyTosend = {
        "phone": _mobileNumberController.text,
        "referrer": referrer
      };
      log("PARAMS TO SEND $bodyTosend");
      try {
        final response =
            await _signInRepo.registerCustomer(context, bodyTosend);
        log("RESPONSE $response");

        if (response['status'] ||
            response['data'] == "Number already registered") {
          await loginCustomer(context);
        }
        loading = false;
        notifyListeners();
      } catch (e) {
        log('Erroer $e');
      }
    }
  }

  Future loginCustomer(BuildContext context) async {
    if (_mobileNumberController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Invalid Phone Number"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      loading = true;
      var bodyTosend = {
        "phone": _mobileNumberController.text //,"referrer":"AZUVQ"
      };
      log("PARAMS TO SEND $bodyTosend");
      try {
        final response = await _signInRepo.loginCustomer(context, bodyTosend);
        log("login response $response");

        if (response['status'] == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return OTPVerificationScreen();
              },
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['data']),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1),
            ),
          );
        }

        loading = false;
        notifyListeners();
      } catch (e) {
        log('Erroer $e');
      }
    }
  }

  Future loginOtpVerificationCustomer(BuildContext context, otp) async {
    loading = true;
    var bodyTosend = {
      "phone": _mobileNumberController.text, //,"referrer":"AZUVQ"
      "otp": otp
    };
    log("PARAMS TO SEND $bodyTosend");
    try {
      final response = await _signInRepo.verifyOTPCustomer(context, bodyTosend);
      log("OTP RESPONSE  $response");

      if (response['status'] == true) {
        token = response['token'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("token", token);
        CustomerProfile _provider =
            Provider.of<CustomerProfile>(context, listen: false);
        await _provider.getProfile(context);
        dynamic route = RegisterScreen();
        try {
          if (_provider.currCustomerProfile!.firstName.isNotEmpty) {
            await LocationServices().checkPermissions();
            Position position = await LocationServices().currentLocation();
            route = Home(startingPosition: position);
          }
        } catch (e) {
          log("There is some error");
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => route,
          ),
        );
      } else {
        Utils.showMyDialog("${response['data']}", context);
      }

      loading = false;
      notifyListeners();
    } catch (e) {
      log('Erroer $e}');
    }
  }
}
