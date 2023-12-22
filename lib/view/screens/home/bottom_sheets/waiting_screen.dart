import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/utils/NavigationService.dart';
import 'package:uber_pro_kolkata/utils/distance_utils.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';
import 'package:uber_pro_kolkata/web_socket/trip_socket.dart';

class WaitingScreenRide extends StatefulWidget {
  final Function onSubmit;
  final Position startingPosition;

  const WaitingScreenRide(
      {super.key, required this.onSubmit, required this.startingPosition});

  @override
  State<WaitingScreenRide> createState() => _WaitingScreenRideState();
}

class _WaitingScreenRideState extends State<WaitingScreenRide> {
  TextStyle get simpleText => TextStyle(fontSize: 16);

  String startingLocation = "", endingLocation = "";

  TextStyle get boldText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  moveToNextScreen(BuildContext context) async {
    LocationProvider _provider = Provider.of<LocationProvider>(context);
    LatLng from = LatLng(
        _provider.pickUpPosition.latitude, _provider.pickUpPosition.longitude);
    LatLng to = LatLng(_provider.destinationPosition.latitude,
        _provider.destinationPosition.longitude);
    getDistance(from, to, bookRideDetails);
  }

  bookRideDetails(distance, time) async {
    double distanceDouble =
        double.parse(distance.replaceAll(RegExp(r'[^0-9.]'), ''));

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

    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);

    Map<String, dynamic> map = {
      "is_active": true,
      "source": sourceAddress,
      "destination": destinationAddress,
      "distance": distanceDouble,
      "timing": DateTime.now().toString(),
      "customer": customerProvider.currCustomerProfile?.id ?? -1,
      "ride_type": _provider.cabClassId,
      "amount": _provider.priceAmount,
      "customer_phone": customerProvider.phoneNumber ??
          customerProvider.currCustomerProfile?.phone,
      "payment_choice": _provider.paymentMethod
    };

    await viewModel.startTrip(context, map);

    await TripWebSocket().webSocketInit(_provider.cabClassId);
    Map socketData = {
      "source": sourceAddress,
      "destination": destinationAddress,
      "phone_number": customerProvider.phoneNumber ??
          customerProvider.currCustomerProfile?.phone,
      "name": customerProvider.currCustomerProfile?.firstName ?? "No Name",
      "trip_id": viewModel.currentTrip?.id ?? -1,
      "customer_id": customerProvider.currCustomerProfile?.id ?? 96,
      "status": "ACCEPTED",
    };
    TripWebSocket().addMessage(socketData);
    TripWebSocket().listenSocket(
        NavigationService.navigatorKey.currentContext ?? context,
        widget.startingPosition);
  }

  void setLocationData() {
    LocationProvider _provider = Provider.of<LocationProvider>(context);
    setState(() {
      startingLocation = _provider.pickUpText;
      endingLocation = _provider.destinationText;
    });
  }

  @override
  Widget build(BuildContext context) {
    setLocationData();

    moveToNextScreen(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Contacting Drivers Nearby..",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          // LinearProgressIndicator(
          //   backgroundColor: Colors.grey,
          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          //   value: 0.2,
          // ),
          // SizedBox(
          //   height: 25,
          // ),
          // CircleAvatar(
          //   backgroundColor: AppColor.btncoloryellow,
          //   // Set the background color here
          //   radius: 50.0,
          //   // Set the desired radius for the circle
          //   child: Icon(
          //     Icons.drive_eta_rounded,
          //     color: Colors.black, // Set the icon color
          //     size: 75.0, // Set the icon size
          //   ),
          // ),
          SizedBox(
            height: 150,
            width: AppSceenSize.getWidth(context) * 0.9,
            child: Lottie.asset('assets/animation/animation_2.json',
                fit: BoxFit.fill),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            width: AppSceenSize.getWidth(context) * 0.90,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.btncoloryellow),
              ),
              onPressed: () async {
                Map map = {
                  "status": "CANCELLED",
                };

                TripViewModel viewModel =
                    Provider.of<TripViewModel>(context, listen: false);
                await viewModel.editTrip(
                    context, map, viewModel.currentTrip?.id ?? -1);
                TripWebSocket().addMessage(map);
                TripWebSocket().closeSocket();
                widget.onSubmit(1);
              },
              child: Text('Cancel Ride'),
            ),
          ),
        ],
      ),
    );
  }
}
