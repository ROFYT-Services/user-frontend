import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class CouponRepo {
  final _networkService = NetworkApiService();

  Future getCouponList(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/cab-booking-api/valide-coupon-code-list/",
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

  Future checkCouponData(context, map) async {
    try {
      final response = await _networkService
          .postApiResponse(
            "${NetworkApiService.baseUrl}/cab-booking-api/apply-coupon/",
            map,
            SignInViewModel.token,
          )
          .catchError(
            (error, stackTrace) {},
          );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
