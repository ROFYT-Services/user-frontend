import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  String _pickUpText = "My Current Location";
  String _destinationText = "Select the location";

  // String _destinationText = "Jogiwala, Dehradun, Uttarakhand";
  // String _pickUpText =
  //     "Rispana Pull, Shastri Nagar, Ajabpur Kalan, Dehradun, Uttarakhand";
  // LatLng _pickUpPosition = const LatLng(30.2940767, 30.2940767);
  // LatLng _destinationPosition = const LatLng(30.2857815, 30.2857815);

  String _mySelf = "MySelf";

  LatLng _pickUpPosition = const LatLng(0, 0);
  LatLng _destinationPosition = const LatLng(0, 0);

  int _cabClassId = -1;
  int _priceValue = -1;

  String get pickUpText => _pickUpText;

  String get mySelf => _mySelf;

  LatLng get pickUpPosition => _pickUpPosition;

  String get destinationText => _destinationText;

  LatLng get destinationPosition => _destinationPosition;

  int get cabClassId => _cabClassId;

  int get priceAmount => _priceValue;
  DateTime? scheduleTime;

  DateTime? get getScheduleTime => scheduleTime;
  String paymentMethod = "QR_CODE";

  void setPaymentMethod(String st) {
    if (st == "Cash") st = "QR_CODE";
    paymentMethod = st;
    notifyListeners();
  }

  void setPriceValue(int id) {
    _priceValue = id;
    notifyListeners();
  }

  void setCabClassId(int id) {
    _cabClassId = id;
    notifyListeners();
  }

  void setscheduleTime(DateTime time) {
    scheduleTime = time;
    notifyListeners();
  }

  void setPickUpString(String st) {
    _pickUpText = st;
    notifyListeners();
  }

  void setPositionPickUp(LatLng value) {
    _pickUpPosition = value;
    notifyListeners();
  }

  void setDestinationString(String st) {
    _destinationText = st;
    notifyListeners();
  }

  void setPositionDestination(LatLng value) {
    _destinationPosition = value;
    notifyListeners();
  }

  void setMySelfValue(String st) {
    _mySelf = st;
    notifyListeners();
  }
}
