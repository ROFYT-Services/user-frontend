import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/coupon_model.dart';
import 'package:uber_pro_kolkata/repository/coupon_repo.dart';

class CouponViewModel extends ChangeNotifier {
  final _couponRepo = CouponRepo();

  List<CouponModel> couponList = [];

  Future<void> getCouponList(BuildContext context) async {
    try {
      final response = await _couponRepo.getCouponList(context);
      log("RESPONSE Cab-Class $response");

      List<CouponModel> cabList = List<CouponModel>.from(
          response.map((json) => CouponModel.fromJson(json)));
      couponList = cabList;
      notifyListeners();
    } catch (e) {
      log('Error cab-class $e');
    }
  }

  Future<double> couponStatusCheck(BuildContext context, var bodyTosend) async {
    try {
      final response = await _couponRepo.checkCouponData(
        context,
        bodyTosend,
      );
      log("RESPONSE coupons $response");
      if (response != null) {
        return response["coupon_discount"] * 1.0 ?? -1;
      }
      notifyListeners();
    } catch (e) {
      log('Erroer $e');
    }

    return -1;
  }
}
