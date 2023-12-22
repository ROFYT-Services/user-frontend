import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/rating_model.dart';
import 'package:uber_pro_kolkata/repository/rating_repo.dart';

class RatingViewModel extends ChangeNotifier {
  final _ratingRepo = RatingRepo();

  List<TripRating> tripList = [];

  Future giveRating(BuildContext context, var bodyTosend) async {
    try {
      final response = await _ratingRepo.writeFeedback(
        context,
        bodyTosend,
      );
      log("RESPONSE $response");
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }
  }

// Future<void> getRatings(BuildContext context) async {
//   try {
//     final response = await _ratingRepo.getTrips(context);
//     log("RESPONSE GET $response");
//
//     List<dynamic> jsonList = response as List;
//     tripList =
//         jsonList.map((jsonItem) => TripRating.fromJson(jsonItem)).toList();
//     notifyListeners();
//   } catch (e) {
//     log('Erroer $e');
//   }
// }
}
