import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/trip_model.dart';
import 'package:uber_pro_kolkata/services/location_service.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view/screens/history/component/driver_info_screen.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';
import 'package:uber_pro_kolkata/web_socket/trip_socket.dart';

class RideDetailScreen extends StatefulWidget {
  final TripModel tripData;
  final int index;

  const RideDetailScreen(
      {Key? key, required this.tripData, required this.index})
      : super(key: key);

  @override
  State<RideDetailScreen> createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  late GoogleMapController _controller;

  TripModel get tripData => widget.tripData;

  late CameraPosition _kGooglePlex;
  int selectedValue = 1;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
      target: LatLng(tripData.destinationLat, tripData.destinationLong),
      zoom: 14.4746,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.AppThemecolor,
        title: Text("Ride details"),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: AppSceenSize.getHeight(context),
            child: Column(
              children: [
                SizedBox(
                  width: AppSceenSize.getWidth(context),
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                  ),
                ),
                _buildBottomSheet(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    DateTime now = DateTime.parse(tripData.timing);
    String formattedDate = DateFormat('dd-MM-yyyy , h:mm a').format(now);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  showImage(tripData.carIcon ?? "", width: 50, height: 50),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    tripData.cabData.cabClassText ?? "RIDE",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              Text(
                formattedDate,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: [
              Column(
                children: const [
                  Icon(Icons.location_on),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(Icons.location_on)
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pick-up",
                    style: TextStyle(color: Color(0xFFC8C7CC)),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    tripData.source,
                    style: AppTextStyle.onboaringSubtitle,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Drop-off",
                        style: TextStyle(color: Color(0xFFC8C7CC)),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        tripData.destination,
                        style: AppTextStyle.onboaringSubtitle,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          tripData.status == "COMPLETED"
              ? SizedBox.shrink()
              : Container(
                  width: AppSceenSize.getWidth(context) * 0.90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    onPressed: () async {
                      showCancelOptions();
                    },
                    child: Text('Cancel Ride'),
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: AppSceenSize.getWidth(context) * 0.90,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () async {
                if (tripData.cabData.id == null) {
                  context.showErrorSnackBar(
                      message: "No driver Assigned to you");
                  return;
                }
                Position startPosition =
                    await LocationServices().currentLocation();
                try {
                  TripViewModel _tripViewModel =
                      Provider.of<TripViewModel>(context, listen: false);
                  await _tripViewModel.getCurrentTrip(context, tripData.id);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => DriverInfoScreen(
                        startingPosition: startPosition,
                        driverId: tripData.driver,
                        vehicleId: tripData.cabData.id!),
                  ));
                } catch (e) {
                  context.showErrorSnackBar(
                      message: "No driver Assigned to you");
                }
              },
              child: Text('Ride Details'),
            ),
          ),
        ],
      ),
    );
  }

  void showCancelOptions() {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (BuildContext context,
                void Function(void Function()) setState) {
              return AlertDialog(
                title: Text("Cancel Ride"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RadioListTile(
                      title: Text('Plan Changed'),
                      value: 1,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('Booked another cab'),
                      value: 2,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text('My reason is not listed'),
                      value: 3,
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Don\'t Cancel'),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Map map = {
                        "status": "CANCELLED",
                      };

                      TripViewModel viewModel =
                          Provider.of<TripViewModel>(context, listen: false);
                      viewModel.changeTripDataLocal(widget.index);
                      await viewModel.editTrip(context, map, tripData.id);

                      if (tripData.status == "ACCEPTED") {
                        TripWebSocket().addMessage(map);
                      }
                      TripWebSocket().closeSocket();
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        });
  }
}
