import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PaymentWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int tripId) {
    debugPrint("Started");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/payment-notify/$tripId'),
    );
  }

  void listenSocket(callbackMethod, context) {
    debugPrint("Listen");
    channel!.stream.listen((message) {
      debugPrint("Received $message");
      Utils.showMyDialog("Payment Recieved", context);
    });
  }

  void addMessage() {
    Map data = {
      "payment": "true",
    };
    channel!.sink.add(json.encode(data));
  }
}
