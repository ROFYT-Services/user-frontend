import 'dart:convert' as json_data;

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:uber_pro_kolkata/constant/apiendpoints.dart';

class LocationServices {
  late bool serviceEnabled;
  late LocationPermission permission;

  Future<String> checkPermissions() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return "No Error";
  }

  Future<Position> currentLocation() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<String> getAddressFromLatLng(double lat, double lng) async {
    String host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$host?key=$mapApiKey&language=en&latlng=$lat,$lng';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = json_data.jsonDecode(response.body);
      String formattedAddress = data["results"][0]["formatted_address"];
      return formattedAddress;
    } else {
      return "";
    }
  }
}
