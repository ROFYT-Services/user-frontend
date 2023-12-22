// ignore_for_file: use_build_context_synchronously, prefer_interpolation_to_compose_strings, file_names, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/driverprofile.dart';
import 'package:uber_pro_kolkata/repository/driver_repo.dart';

class DriverViewModel extends ChangeNotifier {
  final _customerProfileRepo = DriverRepo();

  DriverModel? driverModel;

  Future<void> getProfile(BuildContext context, int id) async {
    try {
      final response = await _customerProfileRepo.getProfile(context, id);
      log("RESPONSE GET $response");

      driverModel = DriverModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }
}
