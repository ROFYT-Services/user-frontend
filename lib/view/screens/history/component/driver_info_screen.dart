import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/view/screens/history/component/bottom_sheet.dart';
import 'package:uber_pro_kolkata/view/widgets/drawer/drawerscreent.dart';

class DriverInfoScreen extends StatefulWidget {
  final Position startingPosition;
  final int driverId;
  final int vehicleId;

  const DriverInfoScreen(
      {super.key,
      required this.startingPosition,
      required this.driverId,
      required this.vehicleId});

  @override
  State<DriverInfoScreen> createState() => _DriverInfoScreen();
}

class _DriverInfoScreen extends State<DriverInfoScreen> {
  late GoogleMapController _controller;
  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2), () {
      _showBottomSheet(context);
    });
    _kGooglePlex = CameraPosition(
      target: LatLng(
          widget.startingPosition.latitude, widget.startingPosition.longitude),
      zoom: 14.4746,
    );
  }

  // Create a GlobalKey to access the Scaffold for the drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(child: drawerScreen(context)),
          body: Stack(
            children: [
              SizedBox(
                height: AppSceenSize.getHeight(context),
                child: Column(
                  children: [
                    SizedBox(
                      width: AppSceenSize.getWidth(context),
                      height: AppSceenSize.getHeight(context) * 0.90,
                      child: GoogleMap(
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller = controller;
                          }),
                    ),
                    GestureDetector(
                      onVerticalDragEnd: (details) {
                        // Detect the swipe up gesture and show the bottom sheet.
                        if (details.primaryVelocity! < 0) {
                          _showBottomSheet(context);
                        }
                      },
                      child: const Center(
                        child: Text(
                          'Swipe Up!',
                          style: TextStyle(fontSize: 24.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    fixedSize: const Size(40, 40)),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey,
                ),
              )
            ],
          )),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: AppSceenSize.getHeight(context) * 0.75,
      ),
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return DriverBottomSheet(
          driverId: widget.driverId,
          vehicleId: widget.vehicleId,
        );
      },
    );
  }
}
