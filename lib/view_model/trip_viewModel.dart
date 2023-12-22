import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/trip_model.dart';
import 'package:uber_pro_kolkata/repository/trip_repo.dart';

class TripViewModel extends ChangeNotifier {
  final _tripRepo = TripRepo();

  List<TripModel> tripList = [];
  TripModel? currentTrip;

  Future startTrip(BuildContext context, var bodyTosend) async {
    try {
      final response = await _tripRepo.startTrip(
        context,
        bodyTosend,
      );
      log("RESPONSE Trip $response");
      currentTrip = TripModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Error in trip $e');
    }
  }

  Future editTrip(BuildContext context, var bodyTosend, int id) async {
    try {
      final response = await _tripRepo.editTrip(
        context,
        bodyTosend,
        id,
      );
      log("RESPONSE $response");
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

  Future<void> getCurrentTrip(BuildContext context, int id) async {
    try {
      final response = await _tripRepo.getCurrentTrip(context, id);
      log("Trip RESPONSE");

      currentTrip = TripModel.fromJson(response);
      notifyListeners();
    } catch (e) {
      log('Error in trip response $e');
    }
  }

  Future<void> getTrips(BuildContext context) async {
    try {
      final response = await _tripRepo.getTrips(context);
      log("Trip RESPONSE");

      List<dynamic> jsonList = response as List;
      tripList =
          jsonList.map((jsonItem) => TripModel.fromJson(jsonItem)).toList();

      tripList.removeWhere((element) => element.status.isEmpty);
      tripList.sort((a, b) {
        DateTime A = DateTime.parse(a.timing);
        DateTime B = DateTime.parse(b.timing);
        return B.compareTo(A);
      });
      notifyListeners();
    } catch (e) {
      log('Error in trip response $e');
    }
  }

  changeTripDataLocal(int index) {
    tripList[index].status = "CANCELLED";
    notifyListeners();
  }
}
