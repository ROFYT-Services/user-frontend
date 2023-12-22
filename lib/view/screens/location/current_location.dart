import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/screens/choose_vehicle_type/choose_vehicle_type.dart';
import 'package:uber_pro_kolkata/view/screens/location/select_manual_location.dart';
import 'package:uber_pro_kolkata/view/widgets/drawer/drawerscreent.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    // Add a delay to give time for the widget tree to render before showing the bottom sheet.
    Future.delayed(Duration(milliseconds: 2), () {
      // _showBottomSheet(context);
    });
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
              Container(
                height: AppSceenSize.getHeight(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: AppSceenSize.getWidth(context),
                      height: AppSceenSize.getHeight(context) * 0.80,
                      child: GoogleMap(
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChooseVehicleType();
                        }));
                      },
                      child: Container(
                        width: AppSceenSize.getWidth(context),
                        height: AppSceenSize.getHeight(context) * 0.08,
                        decoration: BoxDecoration(color: Color(0xFf00B74C)),
                        child: Center(
                          child: Text(
                            'Apply',
                            style:
                                TextStyle(fontSize: 24.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 40,
                    width: AppSceenSize.getWidth(context) * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.grey,
                              ),
                              Text("Axis Mall, Kolkata"),
                            ],
                          ),
                          Image.asset('assets/icons/close.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                color: Colors.grey,
                width: 80,
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
                      Text(
                        "Pick-up",
                        style: TextStyle(color: Color(0xFFC8C7CC)),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        "My current location",
                        style: AppTextStyle.onboaringSubtitle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SelectManuallyLocation();
                          }));
                        },
                        child: Column(
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
                              'newtown',
                              style: AppTextStyle.onboaringSubtitle,
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                  children: List.generate(
                      3,
                      (index) => GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SelectManuallyLocation();
                              }));
                            },
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                height: 30,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(child: Text("Axis Mall")),
                              ),
                            ),
                          )))
            ],
          ),
        );
      },
    );
  }
}
