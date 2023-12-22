import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';

class RazorPayRepo {
  final _networkService = NetworkApiService();
  static String orderId = "";
  static String qrImage = "";

  createOrder(var bodyTosend) async {
    try {
      debugPrint(bodyTosend.toString());
      final response = await _networkService
          .postApiResponse(
              "${NetworkApiService.baseUrl}/payment/create-trip-payment/",
              bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {});
      debugPrint("Response is :- $response");
      if (response != null) {
        orderId = response['order_id'] ?? response['qr_id'] ?? "";
        qrImage = response['image_url'] ?? "";
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  verifySignature(var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse(
              "${NetworkApiService.baseUrl}/payment/verify-trip-signature/",
              bodyTosend,
              SignInViewModel.token)
          .catchError((error, stackTrace) {});
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
