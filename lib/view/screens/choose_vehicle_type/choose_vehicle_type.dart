import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/screens/location/current_location.dart';
import 'package:uber_pro_kolkata/view/widgets/drawer/drawerscreent.dart';
import 'package:uber_pro_kolkata/view_model/choose_vehicle_type.dart';

class ChooseVehicleType extends StatefulWidget {
  const ChooseVehicleType({super.key});

  @override
  State<ChooseVehicleType> createState() => _ChooseVehicleTypeState();
}

class _ChooseVehicleTypeState extends State<ChooseVehicleType> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 14.4746,
  );

  // Create a GlobalKey to access the Scaffold for the drawer.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ChooseVehicleViewModel provider;

  final List _packageList = [
    "Cab share",
    "Economy",
    "Premium",
  ];

  final List _vehicaleSheeter = [
    "Taxi-5 sheeter",
    "Taxi-7 sheeter",
  ];

  final List _paymentOption = ['Paytm', 'Phone pay', 'Google pay', 'Pay pal'];

  String _selectedPayment = 'Paytm';

  @override
  Widget build(BuildContext context) {
    provider = context.watch<ChooseVehicleViewModel>();

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
                      height: provider.isRequest ||
                              provider.isVehicleSelectedView ||
                              provider.packageTapped
                          ? AppSceenSize.getHeight(context) * 0.46
                          : AppSceenSize.getHeight(context) * 0.6,
                      child: GoogleMap(
                          initialCameraPosition: _kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          }),
                    ),
                    _buildBottomSheet(context),
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

  _buildBottomSheet(BuildContext context) {
    return Consumer<ChooseVehicleViewModel>(
      builder: (context, value, child) => Container(
          child: provider.isRequest
              ? _buildVehicleFullView()
              : provider.isVehicleSelectedView
                  ? _buildVehiclePackageView()
                  : provider.packageTapped
                      ? _buildVehicleSelectedView()
                      : _buildDefaultView()),
    );
  }

  _buildVehicleFullView() {
    return SizedBox(
      height: AppSceenSize.getHeight(context) * 0.4,
      child: SizedBox(
        height: AppSceenSize.getHeight(context) * 0.17,
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                provider.setSelectedIndex(index);

                // log("SELECTED $selectedIndex");
              },
              child: Consumer<ChooseVehicleViewModel>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Container(
                    color: value.selectedIndex == index
                        ? const Color(0xFFF0C414)
                        : Colors.transparent,
                    child: ListTile(
                      title: Row(
                        children: [
                          Image.asset("assets/icons/cab.png"),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Cab",
                                style: AppTextStyle.onboaringSubtitle,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Near by you",
                                  style: TextStyle(color: Color(0xFFC8C7CC))),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "\u20B9 100 - \u20B9 250",
                            style: AppTextStyle.onboaringSubtitle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("2min - 10min",
                              style: TextStyle(color: Color(0xFFC8C7CC))),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildDefaultView() {
    return SizedBox(
      height: AppSceenSize.getHeight(context) * 0.3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 4,
                  color: Colors.grey,
                  width: 80,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/cab.png"),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const CurrentLocation();
                              }));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Just go",
                                  style: AppTextStyle.onboaringSubtitle,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Near by you",
                                    style: TextStyle(color: Color(0xFFC8C7CC))),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      //right side

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "-250",
                            style: AppTextStyle.onboaringSubtitle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("2min",
                              style: TextStyle(color: Color(0xFFC8C7CC))),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset("assets/icons/wallet.png"),
                      const Text("Payment",
                          style: TextStyle(color: Color(0xFFC8C7CC))),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset("assets/icons/ticket.png"),
                      const Text("Promo code",
                          style: TextStyle(color: Color(0xFFC8C7CC))),
                    ],
                  ),
                  Column(
                    children: const [
                      Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      ),
                      Text("Options",
                          style: TextStyle(color: Color(0xFFC8C7CC))),
                    ],
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              provider.setIsRequest(true);
            },
            child: Container(
              width: AppSceenSize.getWidth(context) * 0.9,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF0C414),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Center(
                child: Text(
                  "Request",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildVehicleSelectedView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      height: AppSceenSize.getHeight(context) * 0.46,
      child: Column(
        children: [
          SizedBox(
            height: 6,
          ),
          SizedBox(
            height: AppSceenSize.getHeight(context) * 0.18,
            child: ListView.builder(
              itemCount: _vehicaleSheeter.length,
              itemBuilder: (context, index) {
                return Consumer<ChooseVehicleViewModel>(
                  builder: (context, value, child) => ListTile(
                    title: Row(
                      children: [
                        Image.asset("assets/icons/taxi.png"),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _vehicaleSheeter[index],
                              style: AppTextStyle.onboaringSubtitle,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Near by you",
                                style: TextStyle(color: Color(0xFFC8C7CC))),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "\u20B9 250",
                          style: AppTextStyle.onboaringSubtitle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("10min",
                            style: TextStyle(color: Color(0xFFC8C7CC))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset("assets/icons/promo.png"),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: 30,
                      width: AppSceenSize.getWidth(context) * 0.4,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          labelText: 'Enter your promo code',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                          color: const Color(0xFf28B910),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                          child: Text(
                        "Apply",
                        style: TextStyle(color: Colors.white),
                      )))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Method:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Image.asset("assets/icons/paytm.png"),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _selectedPayment,
                              items: _paymentOption.map((item) {
                                return DropdownMenuItem(
                                    value: item, child: Text(item));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedPayment = value.toString();
                                });
                              }),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  provider.bookSuccessFull(context);
                },
                child: Container(
                    height: 50,
                    width: AppSceenSize.getWidth(context) * 0.8,
                    decoration: BoxDecoration(
                        color: const Color(0xFf28B910),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Center(
                        child: Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    ))),
              )
            ],
          )
        ],
      ),
    );
  }

  _buildVehiclePackageView() {
    return Consumer<ChooseVehicleViewModel>(
      builder: (context, value, child) => Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        height: AppSceenSize.getHeight(context) * 0.46,
        child: Column(
          children: [
            SizedBox(
              height: AppSceenSize.getHeight(context) * 0.22,
              child: ListView.builder(
                itemCount: _packageList.length,
                itemBuilder: (context, index) {
                  return Consumer<ChooseVehicleViewModel>(
                    builder: (context, value, child) => ListTile(
                      // selectedTileColor: ,
                      tileColor: value.isPackageclicked[index]
                          ? Color(0xFFF0C414)
                          : Colors.white,
                      onTap: () {
                        provider.setpackageTapped(true);
                        provider.setIsPackageclicked(false, index);
                      },

                      title: Row(
                        children: [
                          Image.asset("assets/icons/cab.png"),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _packageList[index],
                                style: AppTextStyle.onboaringSubtitle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text("Near by you",
                                  style: TextStyle(
                                      color: value.isPackageclicked[index]
                                          ? Colors.white
                                          : Color(0xFFC8C7CC))),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "\u20B9 100 - \u20B9 250",
                            style: AppTextStyle.onboaringSubtitle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("2min - 10min",
                              style: TextStyle(color: Color(0xFFC8C7CC))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset("assets/icons/promo.png"),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: SizedBox(
                          height: 30,
                          width: AppSceenSize.getWidth(context) * 0.4,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Enter your promo code',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              color: const Color(0xFf28B910),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                              child: Text(
                            "Apply",
                            style: TextStyle(color: Colors.white),
                          )))
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Image.asset("assets/icons/paytm.png"),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _selectedPayment,
                                  items: _paymentOption.map((item) {
                                    return DropdownMenuItem(
                                        value: item, child: Text(item));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPayment = value.toString();
                                    });
                                  }),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      provider.bookSuccessFull(context);
                    },
                    child: Container(
                        height: 50,
                        width: AppSceenSize.getWidth(context) * 0.8,
                        decoration: BoxDecoration(
                            color: const Color(0xFf28B910),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          "Book Now",
                          style: TextStyle(color: Colors.white),
                        ))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildVehicleSitterView() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      height: AppSceenSize.getHeight(context) * 0.46,
      child: Column(
        children: [
          SizedBox(
            height: AppSceenSize.getHeight(context) * 0.22,
            child: ListView.builder(
              itemCount: _packageList.length,
              itemBuilder: (context, index) {
                return Consumer<ChooseVehicleViewModel>(
                  builder: (context, value, child) => ListTile(
                    title: Row(
                      children: [
                        Image.asset("assets/icons/cab.png"),
                        const SizedBox(
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _packageList[index],
                              style: AppTextStyle.onboaringSubtitle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Near by you",
                                style: TextStyle(color: Color(0xFFC8C7CC))),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "\u20B9 100 - \u20B9 250",
                          style: AppTextStyle.onboaringSubtitle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("2min - 10min",
                            style: TextStyle(color: Color(0xFFC8C7CC))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset("assets/icons/promo.png"),
                    const SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: SizedBox(
                        height: 30,
                        width: AppSceenSize.getWidth(context) * 0.4,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: 'Enter your promo code',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color(0xFf28B910),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          "Apply",
                          style: TextStyle(color: Colors.white),
                        )))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: const [
                      Text(
                        "Payment Method:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    provider.bookSuccessFull(context);
                  },
                  child: Container(
                      height: 50,
                      width: AppSceenSize.getWidth(context) * 0.8,
                      decoration: BoxDecoration(
                          color: const Color(0xFf28B910),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                          child: Text(
                        "Book Now",
                        style: TextStyle(color: Colors.white),
                      ))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
