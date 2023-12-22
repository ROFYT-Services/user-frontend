import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class DriverRepo {
  final _networkService = NetworkApiService();

  Future getProfile(context, int id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/account/$id/get-driver-profile/",
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
