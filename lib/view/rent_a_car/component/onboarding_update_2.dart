import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/booking_car.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/calendar_screen.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/choose_pickup_location.dart';

import '../../../../constant/app_asset_image.dart';

class OnboardingUpdate2 extends StatefulWidget {
  const OnboardingUpdate2({Key? key}) : super(key: key);

  @override
  State<OnboardingUpdate2> createState() => _OnboardingUpdate2State();
}

class _OnboardingUpdate2State extends State<OnboardingUpdate2>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List _listOfDate = [
    '7',
    '15',
    '1',
    '3',
    '6',
    '9',
    '12',
  ];

  List _listOfDateText = [
    'days',
    'days',
    'months',
    'months',
    'months',
    'months',
    'months',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            AppAssetImage.headerbg,
            width: AppSceenSize.getWidth(context),
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 50,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    SizedBox()
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 50,
            child: Row(
              children: [
                Image.asset(
                  AppAssetImage.logotype,
                  width: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "MY RIDE",
                  style: AppTextStyle.headingText,
                ),
              ],
            ),
          ),
          Positioned(
            top: AppSceenSize.getHeight(context) * 0.35,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: AppSceenSize.getHeight(context) * 0.6,
              width: AppSceenSize.getWidth(context) * 0.9,
              child: Column(
                children: [
                  TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.yellow,
                    indicatorWeight: 3.0,

                    labelColor: Colors.black,
                    labelStyle: AppTextStyle
                        .signuplablestyle, // Set the tab label text color
                    tabs: [
                      Image.asset("assets/icons/cab.png"),
                      Image.asset("assets/icons/bike.png")
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        // CAR  Tab Content
                        _buildCabTabContent(),
                        // Bike tab In Tab Content
                        _buildBikeTabContent(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCabTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChoosePickupLocation();
            }));
          },
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose pick-up location",
                    style: TextStyle(color: Color(0xFf262628)),
                  ),
                ],
              ))),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CalendarScreen();
            }));
          },
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.calendar_month),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose date & time",
                    style: TextStyle(color: Color(0xFf262628)),
                  ),
                ],
              ))),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingCar(),
                ));
          },
          child: Container(
              height: 40,
              width: AppSceenSize.getWidth(context) * 0.3,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                "GO",
                style: TextStyle(color: Color(0xFf4BFB0E), fontSize: 20),
              ))),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Choose your duration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listOfDate.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      height: 60,
                      width: AppSceenSize.getWidth(context) * 0.2,
                      decoration: BoxDecoration(
                          color: Color(0xFfADB507),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _listOfDate[index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            _listOfDateText[index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      )),
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        // const Text(
        //   "Features of Subscription",
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        // const SizedBox(
        //   height: 30,
        // ),
        // Image.asset("assets/icons/chevron.png"),
        // const SizedBox(height: 2),
        // Text("unlimited KMs"),
        // Text("Flexible Payments (EMIs)"),
      ],
    );
  }

  Widget _buildBikeTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChoosePickupLocation();
            }));
          },
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose pick-up location",
                    style: TextStyle(color: Color(0xFf262628)),
                  ),
                ],
              ))),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CalendarScreen();
            }));
          },
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.calendar_month),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose date & time",
                    style: TextStyle(color: Color(0xFf262628)),
                  ),
                ],
              ))),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookingCar(),
                ));
          },
          child: Container(
              height: 40,
              width: AppSceenSize.getWidth(context) * 0.3,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                "GO",
                style: TextStyle(color: Color(0xFf4BFB0E), fontSize: 20),
              ))),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Choose your duration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 80,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _listOfDate.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                      height: 60,
                      width: AppSceenSize.getWidth(context) * 0.2,
                      decoration: BoxDecoration(
                          color: Color(0xFfADB507),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _listOfDate[index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            _listOfDateText[index],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      )),
                );
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        // const Text(
        //   "Features of Subscription",
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        // ),
        // const SizedBox(
        //   height: 30,
        // ),
        // Image.asset("assets/icons/chevron.png"),
        // const SizedBox(height: 2),
        // Text("unlimited KMs"),
        // Text("Flexible Payments (EMIs)"),
      ],
    );
  }
}
