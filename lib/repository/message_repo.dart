import 'package:flutter/foundation.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';

import '../services/api_services.dart';
import '../utils/utils.dart';

class MessageRepo {
  final _networkService = NetworkApiService();

  getMessageRoom(context, int senderId, int receiverId) async {
    try {
      Map map = {
        "sender_receiver": [receiverId, senderId]
      };
      final response = await _networkService
          .postApiResponse("${NetworkApiService.baseUrl}/chat/room-name/", map,
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

  getMessages(context, room) async {
    try {
      final response = await _networkService
          .getGetApiResponse(
              "${NetworkApiService.baseUrl}/chat/$room/messages/",
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
