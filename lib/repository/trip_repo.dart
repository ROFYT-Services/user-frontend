import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class TripRepo {
  final _networkService = NetworkApiService();

  startTrip(context, var bodyTosend) async {
    try {
      final response = await _networkService
          .postApiResponse("${NetworkApiService.baseUrl}/trip/driver-trip/",
              bodyTosend, SignInViewModel.token)
          .catchError((error, stackTrace) {
        Utils.showMyDialog(error.toString(), context);
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  editTrip(context, var bodyTosend, id) async {
    try {
      final response = await _networkService
          .patchApiResponse(
              "${NetworkApiService.baseUrl}/trip/$id/driver-trip/",
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

  getTrips(context) async {
    try {
      final response = await _networkService
          .getGetApiResponse("${NetworkApiService.baseUrl}/trip/customer-trip/",
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

  getCurrentTrip(context, id) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/trip/$id/driver-trip/",
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
