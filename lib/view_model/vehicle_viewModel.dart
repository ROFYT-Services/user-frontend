import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/cab_class.dart';
import 'package:uber_pro_kolkata/models/vehicle_model.dart';
import 'package:uber_pro_kolkata/repository/vehicle_repo.dart';

class VehicleViewModel extends ChangeNotifier {
  final _vehicleRepo = VehicleRepo();

  VehicleModel? vehicle;
  List<CabClass> cabClassList = [];

  Future<void> getVehicle(BuildContext context, int id) async {
    try {
      final response = await _vehicleRepo.getVehicleDetails(context, id);
      log("RESPONSE GET Vehicle $response");
      if (response is List) {
        vehicle = VehicleModel.fromJson(response[0]);
      } else
        vehicle = VehicleModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Error GET Vehicle $e');
    }
  }

  Future<void> getVehicleClass(BuildContext context) async {
    try {
      final response = await _vehicleRepo.getVehicleClass(context);
      log("RESPONSE Cab-Class $response");

      List<CabClass> cabList =
          List<CabClass>.from(response.map((json) => CabClass.fromJson(json)));
      cabClassList = cabList;
      notifyListeners();
    } catch (e) {
      log('Error cab-class $e');
    }
  }
}
