import 'package:flutter/foundation.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class VehicleRepo {
  final _networkService = NetworkApiService();

  getVehicleDetails(context, int id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/cab/$id/get-vehicle/",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      throw e;
    }
  }

  getVehicleClass(
    context,
  ) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/cab-booking-api/cab-class-price-list",
              SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
        if (kDebugMode) {
          print(error.toString());
        }
      });

      return response;
    } catch (e) {
      throw e;
    }
  }
}
