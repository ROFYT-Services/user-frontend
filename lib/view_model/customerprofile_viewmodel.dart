// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/customer_model.dart';
import 'package:uber_pro_kolkata/repository/customer_repo.dart';

class CustomerProfile extends ChangeNotifier {
  final _customerProfileRepo = CustomerProfileRepo();

  String? phoneNumber;

  setPhoneNumber(String number) {
    String simplifiedNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
    phoneNumber = simplifiedNumber;
    notifyListeners();
  }

  CustomerProfileModel? currCustomerProfile;

  Future updateProfile(BuildContext context, bodyTosend) async {
    log("PARAMS TO SEND $bodyTosend");
    try {
      final response = await _customerProfileRepo.updateProfile(
        context,
        bodyTosend,
      );
      log("RESPONSE Update $response");

      currCustomerProfile = CustomerProfileModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future<void> getProfile(BuildContext context) async {
    try {
      final response = await _customerProfileRepo.getProfile(context);
      log("RESPONSE GET $response");

      currCustomerProfile = CustomerProfileModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
