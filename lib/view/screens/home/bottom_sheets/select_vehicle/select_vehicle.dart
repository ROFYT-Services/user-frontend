import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/utils/NavigationService.dart';
import 'package:uber_pro_kolkata/utils/distance_utils.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/ride_scheduled_screen.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/select_vehicle/confirm_ride_screen.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/select_vehicle/select_dateTime_screen.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/select_vehicle/vehicle_selection_sheet.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';
import 'package:uber_pro_kolkata/web_socket/trip_socket.dart';

class SelectVehicleType extends StatefulWidget {
  final Function onSubmit;

  const SelectVehicleType({super.key, required this.onSubmit});

  @override
  State<SelectVehicleType> createState() => _SelectVehicleTypeState();
}

class _SelectVehicleTypeState extends State<SelectVehicleType> {
  int currentIndex = 0;

  void changeCurrentIndex(val) {
    if (val == 0 && currentIndex != 1) {
      widget.onSubmit(2);
    }
    if (currentIndex == 3) {
      widget.onSubmit(0);
    }
    setState(() {
      currentIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return selectScreens();
  }

  Widget selectScreens() {
    if (currentIndex == 0)
      return VehicleSelectionScreen(
        onSubmit: changeCurrentIndex,
      );
    else if (currentIndex == 1)
      return ConfirmVehicleScreen(
        onSubmit: changeCurrentIndex,
      );
    else if (currentIndex == 3) {
      moveToNextScreen(context);
      return ScheduledConfirmRide(
        onSubmit: changeCurrentIndex,
      );
    } else
      return SelectDateTimeScreen(
        onSubmit: changeCurrentIndex,
      );
  }

  moveToNextScreen(BuildContext context) async {
    LocationProvider _provider =
        Provider.of<LocationProvider>(context, listen: false);
    LatLng from = LatLng(
        _provider.pickUpPosition.latitude, _provider.pickUpPosition.longitude);
    LatLng to = LatLng(_provider.destinationPosition.latitude,
        _provider.destinationPosition.longitude);
    getDistance(from, to, bookRideDetails);
  }

  bookRideDetails(distance, time) async {
    LocationProvider locationProvider =
        Provider.of<LocationProvider>(context, listen: false);
    double distanceDouble =
        double.parse(distance.replaceAll(RegExp(r'[^0-9.]'), ''));
    String startingLocation = locationProvider.pickUpText;
    String endingLocation = locationProvider.destinationText;

    LocationProvider _provider =
        Provider.of<LocationProvider>(context, listen: false);
    String sourceAddress = startingLocation +
        "#" +
        _provider.pickUpPosition.latitude.toString() +
        "#" +
        _provider.pickUpPosition.latitude.toString();
    String destinationAddress = endingLocation +
        "#" +
        _provider.destinationPosition.latitude.toString() +
        "#" +
        _provider.destinationPosition.latitude.toString();

    CustomerProfile customerProvider =
        Provider.of<CustomerProfile>(context, listen: false);
    Map<String, dynamic> map = {
      "is_active": true,
      "status": "BOOKED",
      "source": sourceAddress,
      "destination": destinationAddress,
      "distance": distanceDouble,
      "timing": _provider.scheduleTime.toString(),
      "customer": customerProvider.currCustomerProfile?.id ?? -1,
      "ride_type": _provider.cabClassId,
      "amount": _provider.priceAmount,
    };

    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);
    await viewModel.startTrip(context, map);

    await TripWebSocket().webSocketInit(_provider.cabClassId);
    Map socketData = {
      "source": sourceAddress,
      "destination": destinationAddress,
      "phone_number": customerProvider.currCustomerProfile?.phone ?? "100",
      "name": customerProvider.currCustomerProfile?.firstName ?? "No Name",
      "trip_id": viewModel.currentTrip?.id ?? -1,
      "status": "SCHEDULED",
      "timing":
          DateFormat('dd-MM-yyyy , h:mm a').format(_provider.scheduleTime!),
      "customer_id": customerProvider.currCustomerProfile?.id ?? 96,
    };
    TripWebSocket().addMessage(socketData);
    LatLng from = LatLng(locationProvider.pickUpPosition.latitude,
        locationProvider.pickUpPosition.longitude);
    TripWebSocket().listenSocket(
        NavigationService.navigatorKey.currentContext ?? context, from);
  }
}
