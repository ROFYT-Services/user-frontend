import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/driverprofile.dart';
import 'package:uber_pro_kolkata/models/vehicle_model.dart';
import 'package:uber_pro_kolkata/utils/distance_utils.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/view/screens/history/component/chat.dart';
import 'package:uber_pro_kolkata/view/screens/rating/tips.dart';
import 'package:uber_pro_kolkata/view/screens/splash/splash.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/driver_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/vehicle_viewModel.dart';
import 'package:uber_pro_kolkata/web_socket/trip_detail_socket.dart';
import 'package:uber_pro_kolkata/web_socket/trip_socket.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverBottomSheet extends StatefulWidget {
  final int driverId;
  final int vehicleId;

  const DriverBottomSheet(
      {super.key, required this.driverId, required this.vehicleId});

  @override
  State<DriverBottomSheet> createState() => _DriverBottomSheetState();
}

class _DriverBottomSheetState extends State<DriverBottomSheet> {
  String startingLocation = "";
  String endingLocation = "";
  String distance = "0.0 Km";
  String time = "0 Min";
  String otpText = "";
  bool isLoading = false;

  void toogleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  DriverModel model = DriverModel();
  VehicleModel vehicleModel = VehicleModel();

  @override
  void initState() {
    super.initState();
    readData();
    setLocationData();
  }

  void setLocationData() {
    TripViewModel _tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);

    setState(() {
      startingLocation = _tripViewModel.currentTrip?.source ?? "Source Address";
      endingLocation = _tripViewModel.currentTrip?.destination ?? "Destination";
    });
  }

  void readData() async {
    debugPrint("Driver ${widget.driverId} Vehicle ${widget.vehicleId}");

    DriverViewModel _provider =
        Provider.of<DriverViewModel>(context, listen: false);
    VehicleViewModel _vehicleProvider =
        Provider.of<VehicleViewModel>(context, listen: false);
    TripViewModel _tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);

    if (_provider.driverModel == null) {
      await _provider.getProfile(context, widget.driverId);
    }
    setState(() {
      model = _provider.driverModel!;
      otpText = _tripViewModel.currentTrip!.otpCount.toString();
    });
    if (_vehicleProvider.vehicle == null) {
      await _vehicleProvider.getVehicle(context, widget.vehicleId);
    }
    setState(() {
      vehicleModel = _vehicleProvider.vehicle ?? VehicleModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    TripViewModel _tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildOTPField(),
            const SizedBox(
              height: 20,
            ),
            _buildProfileSection(),
            const SizedBox(
              height: 20,
            ),
            _buildCarDetail(),
            const SizedBox(
              height: 20,
            ),
            _buildLocationSection(),
            const SizedBox(
              height: 40,
            ),
            _buildPriceSection(),
            const SizedBox(
              height: 40,
            ),
            _buildCancelButton(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Total Fare ${(_tripViewModel.currentTrip?.amount ?? 0)}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  TripViewModel _tripViewModel =
                      Provider.of<TripViewModel>(context, listen: false);
                  CustomerProfile customerProvider =
                      Provider.of<CustomerProfile>(context, listen: false);
                  TripSecurityWebSocket().webSocketInit(
                      _tripViewModel.currentTrip?.id ?? 18,
                      customerProvider.currCustomerProfile?.photoUpload ?? "");
                },
                leading: Icon(Icons.share),
                title: Text(
                  "Share your Live Location",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => TipsScreen()));

                  // showConfirmBookingDialog();
                },
                leading: Icon(Icons.money),
                title: Text(
                  "Pay via UPI, card or more",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _buildCarDetail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vehicleModel.modelText.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              vehicleModel.numberplate.toString(),
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.car_rental_sharp,
            size: 50,
          ),
        )
      ],
    );
  }

  _buildProfileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            showImage(model.photoupload),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(model.firstname ?? "No Name"),
                Row(
                  children: const [
                    Icon(Icons.star, color: Color(0xFFFFCC00)),
                    Text("4.9")
                  ],
                )
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatScreen(model: model);
                  }));
                },
                child: Image.asset(
                  'assets/icons/message.png',
                  width: 60,
                  height: 60,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Uri phoneNumber = Uri.parse('tel:${model.phone}');
                  await launchUrl(phoneNumber);
                },
                child: Image.asset(
                  'assets/icons/call.png',
                  width: 60,
                  height: 60,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildLocationSection() {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: AppSceenSize.getWidth(context) * 0.8,
              child: Text(
                startingLocation,
                style: AppTextStyle.onboaringSubtitle,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(Icons.location_on),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              width: AppSceenSize.getWidth(context) * 0.8,
              child: Text(
                endingLocation,
                style: AppTextStyle.onboaringSubtitle,
              ),
            )
          ],
        ),
      ],
    );
  }

  void setDistance(String distanceText, String timeText) {
    setState(() {
      distance = distanceText;
      time = timeText;
    });
  }

  _buildPriceSection() {
    LocationProvider _provider = Provider.of<LocationProvider>(context);

    TripViewModel _tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);
    LatLng startLocation = _provider.pickUpPosition;
    LatLng endLocation = _provider.destinationPosition;
    if (distance == "0.0 Km")
      getDistance(startLocation, endLocation, setDistance);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/icons/cab.png"),
        Column(
          children: [
            Text(
              "Distance",
              style: TextStyle(color: Color(0xFFC8C7CC)),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              distance,
              style: AppTextStyle.onboaringSubtitle,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Time",
              style: TextStyle(color: Color(0xFFC8C7CC)),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              time,
              style: AppTextStyle.onboaringSubtitle,
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "price",
              style: TextStyle(color: Color(0xFFC8C7CC)),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              (_tripViewModel.currentTrip?.amount ?? 0).toString(),
              style: AppTextStyle.onboaringSubtitle,
            ),
          ],
        ),
      ],
    );
  }

  _buildCancelButton() {
    TripViewModel _tripViewModel =
        Provider.of<TripViewModel>(context, listen: false);

    TripViewModel viewModel =
        Provider.of<TripViewModel>(context, listen: false);
    if (_tripViewModel.currentTrip?.status == "COMPLETED") {
      return SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () async {
        Map map = {
          "status": "CANCELLED",
        };

        await viewModel.editTrip(
            context, map, _tripViewModel.currentTrip?.id ?? -1);
        TripWebSocket().addMessage(map);
        TripWebSocket().closeSocket();
        Navigator.of(context).popUntil((route) {
          return false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SplashScreen(),
            ));
        // Navigator.of(context).popUntil((route) => (route is Home));
      },
      child: Container(
          height: 50,
          width: AppSceenSize.getWidth(context),
          decoration: BoxDecoration(
              color: const Color(0xFf242E42),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
              child: Text(
            "Cancel Ride",
            style: TextStyle(color: Colors.white),
          ))),
    );
  }

  _buildOTPField() {
    return Container(
        height: 50,
        width: AppSceenSize.getWidth(context),
        decoration: BoxDecoration(
            color: const Color(0xFf242E42),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Share this ‘OTP’ to  verify your ride ",
              style: TextStyle(color: Colors.white),
            ),
            Container(
                height: 35,
                width: 75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  otpText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ))
          ],
        ));
  }
}
