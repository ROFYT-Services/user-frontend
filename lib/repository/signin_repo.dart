import 'package:flutter/foundation.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class SignInRepo {
  final _networkService = NetworkApiService();

  registerCustomer(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .registerApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-register/",
              bodyTosend)
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

  loginCustomer(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .registerApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-login-with-phone/",
              bodyTosend)
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

  verifyOTPCustomer(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .registerApiResponse(
              "${NetworkApiService.baseUrl}/account/customer-otp-verify/",
              bodyTosend)
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
