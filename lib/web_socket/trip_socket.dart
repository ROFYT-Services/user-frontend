import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/utils/local_notification.dart';
import 'package:uber_pro_kolkata/view/screens/history/component/driver_info_screen.dart';
import 'package:uber_pro_kolkata/view/screens/rating/tips.dart';
import 'package:uber_pro_kolkata/view/screens/splash/splash.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TripWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int id) async {
    debugPrint("Started $id");
    channel = await WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-notify/$id'),
    );
  }

  void listenSocket(context, startingPosition) {
    debugPrint("Listen");
    channel!.stream.listen((message) async {
      debugPrint("Received $message");
      Map map = jsonDecode(message);

      if (map["status"] == "SCHEDULED") return;
      if (map["driver_id"] != null && map["vehicle_id"] != null) {
        debugPrint("${map["driver_id"]} ${map["vehicle_id"]}");

        LocalNotificationService().showNotification(
            "Ride accepted", "A rider has accepted your request");

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DriverInfoScreen(
              startingPosition: startingPosition,
              driverId: map["driver_id"],
              vehicleId: map["vehicle_id"]),
        ));
      } else if (map["status"] == "DRIVER_REJECTED") {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
              "Ride has been cancelled by driver",
              style: TextStyle(color: Colors.white),
              maxLines: 2,
            ),
            backgroundColor: Colors.red,
          ));
        Navigator.of(context).popUntil((route) {
          return false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
      } else if (map["status"] == "COMPLETED") {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => TipsScreen()));
      }
    });
  }

  void addMessage(Map map) {
    channel!.sink.add(json.encode(map));
  }

  void closeSocket() {
    if (channel != null) channel!.sink.close();
  }
}
