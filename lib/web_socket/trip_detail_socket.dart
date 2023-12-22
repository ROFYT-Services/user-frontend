import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_pro_kolkata/utils/distance_utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TripSecurityWebSocket {
  static WebSocketChannel? channel;

  webSocketInit(int tripId, String url) async {
    debugPrint("Started");
    channel = WebSocketChannel.connect(
      Uri.parse('ws://3.109.183.75:7401/ws/trip-tracking/$tripId'),
    );
    Timer.periodic(Duration(seconds: 3), (Timer t) async {
      try {
        LatLng currentLocation = await getCurrentLocation();
        addMessage(currentLocation.latitude, currentLocation.longitude, url);
      } catch (e) {
        print("Error getting location: $e");
      }
    });
  }

  void listenSocket(callbackMethod, context) {
    debugPrint("Listen");
  }

  void addMessage(double lat, double lon, String url) {
    Map data = {
      "customer_lat": lat,
      "customer_long": lon,
      "customer_url": url,
    };
    channel!.sink.add(json.encode(data));
  }
}
