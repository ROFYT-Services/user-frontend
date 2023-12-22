import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class RatingRepo {
  final _networkService = NetworkApiService();

  writeFeedback(context, var bodyTosend) async {
    try {
      debugPrint("${SignInViewModel.token}");
      final response = await _networkService
          .postApiResponse("${NetworkApiService.baseUrl}/trip/trip-feedback/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        debugPrint("${error.toString()}");
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  editFeedback(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .patchApiResponse("${NetworkApiService.baseUrl}/trip/trip-feedback/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  getFeedbackData(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("${NetworkApiService.baseUrl}/trip/trip-feedback/",
              SignInViewModel.token)
          .catchError(
        (error, stackTrace) {
          Utils.showMyDialog(error.toString(), context);
        },
      );
      //DriverProfile driverProfile = DriverProfile.fromJson(response);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
