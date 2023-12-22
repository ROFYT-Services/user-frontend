import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/models/message_model.dart';
import 'package:uber_pro_kolkata/repository/message_repo.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';

class MessageViewModel extends ChangeNotifier {
  final _messageRepo = MessageRepo();

  String roomKey = "";
  List<Message> messageList = [];

  Future<void> getMessageRoom(
      BuildContext context, int senderId, int receiverId) async {
    try {
      final response =
          await _messageRepo.getMessageRoom(context, senderId, receiverId);
      log("RESPONSE GET room Message $response");

      roomKey = response["room"]["room"];
      notifyListeners();
    } catch (e) {
      context.showErrorSnackBar(message: "Error while getting room");
      log('Error GET room Message $e');
    }
  }

  Future<void> getMessages(
      BuildContext context, int senderId, int specificId, String room) async {
    try {
      final response = await _messageRepo.getMessages(context, room);
      log("RESPONSE Cab-Class $response");

      if (response == null) return;
      messageList = List<Message>.from(
        response.map(
          (m) => Message.fromJson(m, senderId),
        ),
      );
      // messageList.removeWhere((message) => message.receiver != specificId);
      notifyListeners();
    } catch (e) {
      context.showErrorSnackBar(message: "Error while getting message");

      log('Error cab-class $e');
    }
  }
}
