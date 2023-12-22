import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/apiendpoints.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/services/location_service.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/location_detail_sheet.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/select_vehicle/select_vehicle.dart';
import 'package:uber_pro_kolkata/view/screens/home/bottom_sheets/waiting_screen.dart';
import 'package:uber_pro_kolkata/view/widgets/drawer/drawerscreent.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.startingPosition});

  final Position startingPosition;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double bottomSheetHeight = 0.4;
  int currentIndex = 0;
  Set<Marker> markersList = {};
  late GoogleMapController _controller;
  String startingLocation = "My Current Location";
  String endingLocation = "Select the location";

  bool onDuty = true;
  String onOfText = "YES";

  Position get startingPosition => widget.startingPosition;
  late CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    readData(startingPosition.latitude, startingPosition.longitude);
    _kGooglePlex = CameraPosition(
      target: LatLng(startingPosition.latitude, startingPosition.longitude),
      zoom: 14.4746,
    );
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        bottomSheetHeight = visible ? 0.75 : (currentIndex == 1 ? 0.65 : 0.4);
      });
    });
  }

  void showBottomSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        minWidth: AppSceenSize.getHeight(context) * 0.75,
      ),
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SelectVehicleType(
          onSubmit: changeIndex,
        );
      },
    );
  }

  Future<String> readData(double lat, double lng) async {
    try {
      var text = await LocationServices().getAddressFromLatLng(lat, lng);
      if (text.isNotEmpty) {
        setState(() {
          startingLocation = text;
        });
        LocationProvider _provider =
            Provider.of<LocationProvider>(context, listen: false);
        _provider.setPickUpString(text);
        _provider.setPositionPickUp(LatLng(lat, lng));
      }

      return text;
    } catch (e) {
      debugPrint("No address found");
    }
    return "";
  }

  void changeIndex(val) {
    // if (val == 1) showBottomSheet();
    setState(() {
      currentIndex = val;
      bottomSheetHeight = val == 1 ? 0.65 : 0.4;
    });
  }

  void setLocationData() {
    LocationProvider _provider = Provider.of<LocationProvider>(context);
    setState(() {
      startingLocation = _provider.pickUpText;
      endingLocation = _provider.destinationText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

// Create a GlobalKey to access the Scaffold for the drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    setLocationData();
    CustomerProfile _provider =
        Provider.of<CustomerProfile>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        if (currentIndex == 0) return true;
        changeIndex(currentIndex - 1);
        return false;
      },
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
                    height: MediaQuery.of(context).size.height *
                        (1 - bottomSheetHeight),
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: _kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      markers: markersList,
                    ),
                  ),
                  _buildBottomSheet(context)
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 25,
              child: InkWell(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.menu,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            if (_provider.currCustomerProfile!.gender == "Female")
              Positioned(
                top: 50,
                right: 45,
                left: 85,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      tooltipkey.currentState
                                          ?.ensureTooltipVisible();
                                    },
                                    child: Tooltip(
                                        key: tooltipkey,
                                        preferBelow: true,
                                        message: "Are you riding Alone.?",
                                        child: Icon(Icons.error)),
                                  ),
                                  Text("Riding alone?"),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Switch(
                                inactiveThumbColor: Colors.red,
                                value: onDuty,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  late String text;
                                  if (onOfText == "NO") {
                                    text = "YES";
                                  } else {
                                    text = "NO";
                                  }
                                  setState(() {
                                    onDuty = value;
                                    onOfText = text;
                                  });
                                }),
                          )
                        ],
                      ),
                      if (currentIndex == 1) locationView(),
                    ],
                  ),
                ),
              ),
            if (currentIndex == 0)
              Positioned(
                bottom:
                    (MediaQuery.of(context).size.height * bottomSheetHeight -
                        45),
                right: 25,
                left: 25,
                child: Card(
                  elevation: 10,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: carIconText(
                            "Book a Cab",
                            Image.asset(
                              "assets/icons/car1.png",
                              height: 25,
                              width: 25,
                            ),
                            0),
                        flex: 1,
                      ),
                      Expanded(
                        child: carIconText(
                            "Rent a Car",
                            Image.asset(
                              "assets/icons/car1.png",
                              height: 25,
                              width: 25,
                            ),
                            1),
                        flex: 1,
                      )
                    ],
                  ),
                ),
              ),
            Positioned(
                bottom:
                    (MediaQuery.of(context).size.height * bottomSheetHeight +
                        50),
                right: 25,
                child: IconButton(
                    onPressed: () async {
                      Position position =
                          await LocationServices().currentLocation();
                      _kGooglePlex = CameraPosition(
                        target: LatLng(position.latitude, position.longitude),
                        zoom: 14.4746,
                      );
                      _controller.animateCamera(
                          CameraUpdate.newCameraPosition(_kGooglePlex));
                      readData(position.latitude, position.longitude);
                    },
                    icon: Icon(Icons.my_location_outlined))),
          ],
        ),
      ),
    );
  }

  int rideIndex = 0;

  overFlowedText(String text, {double width = 0.5}) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  locationView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: AppSceenSize.getWidth(context) * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 15,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    overFlowedText(startingLocation)
                  ],
                ),
                customDivider(),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.red,
                      size: 15,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    overFlowedText(endingLocation)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget carIconText(String title, Image icon, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          rideIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            icon,
            Text(title),
            index == rideIndex
                ? Center(
                    child: Container(
                      width: 50,
                      height: 2,
                      color: Colors.black,
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  _buildBottomSheet(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * bottomSheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: [
        rideIndex == 0
            ? LocationDetailBottomSheet(
                onSubmit: changeIndex,
                showSearchBar: showSearchBar,
              )
            : Center(
                child: Text(
                "Coming Soon....",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
        SelectVehicleType(onSubmit: changeIndex),
        WaitingScreenRide(
            onSubmit: changeIndex, startingPosition: startingPosition),
        // 3
      ][currentIndex],
    );
  }

  void showSearchBar(bool isPickup) async {
    var place = await PlacesAutocomplete.show(
        context: context,
        apiKey: mapApiKey,
        mode: Mode.overlay,
        types: [],
        strictbounds: false,
        components: [Component(Component.country, 'IN')],
        onError: (err) {
          debugPrint("$err");
        });

    if (place != null) {
      LocationProvider _provider =
          Provider.of<LocationProvider>(context, listen: false);
      if (isPickup) {
        _provider.setPickUpString(place.description.toString());
      } else {
        _provider.setDestinationString(place.description.toString());
      }

      final plist = GoogleMapsPlaces(
        apiKey: mapApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      String placeId = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeId);

      final geometry = detail.result.geometry!;
      double latitude = geometry.location.lat;
      double longitude = geometry.location.lng;

      showDestinationMarker(LatLng(latitude, longitude), isPickup.toString(),
          isPickup ? "pick_up" : "drop_off");

      if (isPickup) {
        _provider.setPositionPickUp(LatLng(latitude, longitude));
      } else {
        _provider.setPositionDestination(LatLng(latitude, longitude));
      }

      CameraPosition pickupLocation = CameraPosition(
        target: LatLng(latitude, longitude),
        zoom: 14.4746,
      );

      _controller.moveCamera(CameraUpdate.newCameraPosition(pickupLocation));
    }
  }

  void showDestinationMarker(LatLng latLng, String id, String photo) async {
    Uint8List markIcons = await getImages('assets/icons/$photo.png', 150);

    Marker tmpMarker = Marker(
      markerId: MarkerId(id),
      position: latLng,
      icon: BitmapDescriptor.fromBytes(markIcons),
    );
    if (mounted) {
      setState(() {
        markersList.add(tmpMarker);
      });
    }
  }
}
