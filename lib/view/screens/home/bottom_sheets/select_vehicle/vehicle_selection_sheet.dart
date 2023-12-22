import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/models/cab_class.dart';
import 'package:uber_pro_kolkata/utils/distance_utils.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view_model/coupon_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';
import 'package:uber_pro_kolkata/view_model/vehicle_viewModel.dart';

class VehicleSelectionScreen extends StatefulWidget {
  final Function onSubmit;

  const VehicleSelectionScreen({super.key, required this.onSubmit});

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  String startingLocation = "", endingLocation = "";
  bool isLoading = false;
  int cabId = -1;
  int selectedIndex = 0;
  List<CabClass> cabClassList = [];
  TextEditingController controller = TextEditingController();
  double totalDistance = 1;
  int carModeSelection = 1;

  @override
  void initState() {
    super.initState();
    getVehicleData();
    getLocations();
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
    return Stack(
      children: [
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              )
            : selectVehicleView(),
        Positioned(
          top: 15,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  carSelectionMode("Share", 2),
                  // customDivider(),
                  carSelectionMode("Economy", 1),
                  // customDivider(),
                  carSelectionMode("Prime", 0),
                  // customDivider(),
                  carSelectionMode("Luxury", 3),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  inputTextField(controller, "Coupon Code", width: 0.5),
                  Container(
                    width: AppSceenSize.getWidth(context) * 0.25,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColor.btncoloryellow),
                      ),
                      onPressed: () async {
                        CouponViewModel couponProvider =
                            Provider.of<CouponViewModel>(context,
                                listen: false);
                        Map map = {"coupon_code": controller.text};
                        try {
                          double discount = await couponProvider
                              .couponStatusCheck(context, map);
                          if (discount == -1) {
                            context.showErrorSnackBar(
                                message:
                                    "Sorry this coupon code is not valid anymore");

                            return;
                          } else {
                            context.showSnackBar(
                                message:
                                    "Hurray! You got $discount % discount");
                          }
                          LocationProvider _provider =
                              Provider.of<LocationProvider>(context,
                                  listen: false);
                          double totalPrice =
                              cabClassList[selectedIndex].price *
                                  (discount / 100.0);
                          totalPrice =
                              cabClassList[selectedIndex].price - totalPrice;
                          _provider.setPriceValue(totalPrice.round());
                        } catch (e) {
                          print("Error $e");
                        }
                      },
                      child: Text('Apply'),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: AppSceenSize.getWidth(context),
                height: 1,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 25,
          left: 15,
          right: 15,
          child: Container(
            width: AppSceenSize.getWidth(context) * 0.90,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.btncoloryellow),
              ),
              onPressed: () async {
                if (cabId == -1) {
                  Utils.showMyDialog("Please seat a ride first", context);
                  return;
                }

                LocationProvider _provider =
                    Provider.of<LocationProvider>(context, listen: false);
                _provider.setCabClassId(cabId);
                _provider
                    .setPriceValue(cabClassList[selectedIndex].price.round());
                // _showCouponCodeDialog(context);
                widget.onSubmit(0);
              },
              child: Text('Book Now'),
            ),
          ),
        ),
      ],
    );
  }

  inputTextField(TextEditingController controller, String hintText,
      {double width = 1}) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * width,
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // hintText: hintText,
            labelText: hintText),
      ),
    );
  }

  carSelectionMode(String title, index) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () async {
          setState(() {
            carModeSelection = index;
          });
          await getVehicleData();
          if (carModeSelection == 0) {
            cabClassList.removeWhere((element) {
              return element.cabClassName != "Prime SUV" &&
                  element.cabClassName != "Prime Sedan";
            });
          } else if (carModeSelection == 1) {
            cabClassList.removeWhere((element) {
              return element.cabClassName != "Bike" &&
                  element.cabClassName != "Sedan" &&
                  element.cabClassName != "5 - Seater" &&
                  element.cabClassName != "7 - Seater" &&
                  element.cabClassName != "Auto";
            });
          } else if (carModeSelection == 2) {
            cabClassList.clear();
          } else if (carModeSelection == 3) {
            cabClassList.removeWhere((element) {
              return element.cabClassName != "Premium";
            });
          }

          debugPrint("Car mode $carModeSelection");
        },
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontSize: 16),
                ),
                if (carModeSelection == index)
                  Container(
                    height: 3,
                    width: 50,
                    color: AppColor.btncoloryellow,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  customDivider() {
    return Container(
      height: 40,
      color: Colors.grey[500],
      width: 2,
    );
  }

  overFlowedText(String text, {double width = 0.6}) {
    return SizedBox(
      width: AppSceenSize.getWidth(context) * width,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  locationView() {
    return Row(
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
        GestureDetector(
          onTap: () {
            if (cabId == -1) {
              Utils.showMyDialog("Please seat a ride first", context);
              return;
            }
            LocationProvider _provider =
                Provider.of<LocationProvider>(context, listen: false);
            _provider.setCabClassId(cabId);
            _provider.setPriceValue(cabClassList[selectedIndex].price.round());
            widget.onSubmit(2);
          },
          child: Card(
            elevation: 5,
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [Icon(Icons.alarm), Text("NOW")],
              ),
            ),
          ),
        )
      ],
    );
  }

  selectVehicleView() {
    return SizedBox(
      width: AppSceenSize.getWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
          ),
          Expanded(
            child: cabClassList.length == 0
                ? Text(
                    "Coming Soon",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: cabClassList.length,
                    itemBuilder: (context, index) {
                      CabClass model = cabClassList[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            cabId = model.id;
                            selectedIndex = index;
                          });
                        },
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: cabId == model.id ? 10 : 0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              leading: GestureDetector(
                                  onTap: () {
                                    widget.onSubmit(1);
                                  },
                                  child: showImage(model.cabClassIcon,
                                      width: 50, height: 50)),
                              title: Text(model.cabClassName),
                              subtitle: Text("Beat the traffic on bike"),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Price",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rs. ${(model.price * totalDistance).round()}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  Future getVehicleData() async {
    toggleLoading();
    VehicleViewModel _vehicleProvider =
        Provider.of<VehicleViewModel>(context, listen: false);

    await _vehicleProvider.getVehicleClass(context);
    setState(() {
      cabClassList = _vehicleProvider.cabClassList;
    });

    toggleLoading();
  }

  void getLocations() async {
    LocationProvider _provider =
        Provider.of<LocationProvider>(context, listen: false);
    LatLng from = LatLng(
        _provider.pickUpPosition.latitude, _provider.pickUpPosition.longitude);
    LatLng to = LatLng(_provider.destinationPosition.latitude,
        _provider.destinationPosition.longitude);
    await getDistance(from, to, bookRideDetails);
  }

  bookRideDetails(distance, time) async {
    double distanceDouble =
        double.parse(distance.replaceAll(RegExp(r'[^0-9.]'), ''));
    setState(() {
      totalDistance = distanceDouble;
    });
  }
}
