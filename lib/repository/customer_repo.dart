import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class CustomerProfileRepo {
  final _networkService = NetworkApiService();

  makeProfile(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .putApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-profile/",
              bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future updateProfile(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .patchApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-profile/",
              bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      debugPrint(response.toString());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future getProfile(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-profile/",
              SignInViewModel.token)
          .catchError(
        (error, stackTrace) {
          Utils.showMyDialog(error.toString(), context);
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
