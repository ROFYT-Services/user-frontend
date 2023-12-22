import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/booking_car.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/calendar_screen.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/choose_pickup_location.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/my_profile.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/onboarding_update_2.dart';

import '../../../constant/app_asset_image.dart';

class RentACar extends StatefulWidget {
  const RentACar({Key? key}) : super(key: key);

  @override
  State<RentACar> createState() => _RentACarState();
}

class _RentACarState extends State<RentACar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  bool _isUp = false;

  void _scrollListener() {
    // Check if the user has reached the end of the list
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    } else if (_scrollController.position.pixels ==
        _scrollController.position.minScrollExtent) {
      _loadLessItems();
    }
  }

  _loadMoreItems() {
    _isUp = true;
    setState(() {});
  }

  _loadLessItems() {
    _isUp = false;
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List _services = [
    "DIFFERENT\n PACKAGES",
    "SUBSCRIPTION \n & SPECIALS",
    "DIFFERENT\n PACKAGES",
    "SUBSCRIPTION \n & SPECIALS",
    "DIFFERENT\n PACKAGES",
    "SUBSCRIPTION \n & SPECIALS"
  ];

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            _buildHeadingSection(),
            _buildTabSection(),
          ],
        ),
      ),
    );
  }

  _buildHeadingSection() {
    return Stack(
      children: [
        Container(
          color: Colors.white,
        ),
        Image.asset(
          AppAssetImage.headerbg,
          width: AppSceenSize.getWidth(context),
          fit: BoxFit.contain,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox()
              ],
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MyProfileScreen();
              }));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/icons/Avatar.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 20,
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
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
      ],
    );
  }

  _buildTabSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: AppSceenSize.getHeight(context) * 0.8,
      width: AppSceenSize.getWidth(context) * 0.9,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.yellow,
              indicatorWeight: 3.0,
              labelColor: Colors.black,
              labelStyle:
                  AppTextStyle.signuplablestyle, // Set the tab label text color
              tabs: [
                Image.asset("assets/icons/cab.png"),
                Image.asset("assets/icons/bike.png")
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              // physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
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
    );
  }

  _buildCabTabContent() {
    return ListView(
      physics: _isUp ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
      controller: _scrollController,
      children: [
        Row(
          children: [
            Radio(value: true, groupValue: "true", onChanged: (value) {}),
            const Text("Return Car to another location")
          ],
        ),
        const SizedBox(
          height: 10,
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
          onTap: () {},
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: const Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: const [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose drop-off location",
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //           height: 80,
        //           width: AppSceenSize.getWidth(context) * 0.3,
        //           decoration: BoxDecoration(
        //               color: const Color(0xFf6C7380),
        //               borderRadius: BorderRadius.circular(5)),
        //           child: const Center(
        //               child: Text(
        //             "DIFFERENT\n PACKAGES",
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.bold),
        //           ))),
        //     ),
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //           height: 80,
        //           width: AppSceenSize.getWidth(context) * 0.3,
        //           decoration: BoxDecoration(
        //               color: Color(0xFf6C7380),
        //               borderRadius: BorderRadius.circular(5)),
        //           child: Center(
        //               child: Text(
        //             "SUBSCRIPTION \n & SPECIALS",
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.bold),
        //           ))),
        //     ),
        //   ],
        // ),

        SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: _services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        height: 80,
                        width: AppSceenSize.getWidth(context) * 0.3,
                        decoration: BoxDecoration(
                            color: const Color(0xFf6C7380),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          _services[index],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))),
                  ),
                );
              }),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OnboardingUpdate2();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                height: 150,
                width: AppSceenSize.getWidth(context),
                decoration: BoxDecoration(
                    color: const Color(0xFf6C7380),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  "Banner Will Come Here",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Frequently Asked Questions",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 200,
          child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text('Expandable Item'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Subitem 1'),
                      ),
                      ListTile(
                        title: Text('Subitem 2'),
                      ),
                    ],
                  ),
                );
              }),
        ),

        SizedBox(
          height: 50,
        )
      ],
    );
  }

  _buildBikeTabContent() {
    return ListView(
      physics: _isUp ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
      controller: _scrollController,
      children: [
        Row(
          children: [
            Radio(value: true, groupValue: "true", onChanged: (value) {}),
            const Text("Return Bike to another location")
          ],
        ),
        const SizedBox(
          height: 10,
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
          onTap: () {},
          child: Container(
              height: 50,
              width: AppSceenSize.getWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: const Color(0xFf6C7380),
                  borderRadius: BorderRadius.circular(5)),
              child: Center(
                  child: Row(
                children: const [
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Choose drop-off location",
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //           height: 80,
        //           width: AppSceenSize.getWidth(context) * 0.3,
        //           decoration: BoxDecoration(
        //               color: const Color(0xFf6C7380),
        //               borderRadius: BorderRadius.circular(5)),
        //           child: const Center(
        //               child: Text(
        //             "DIFFERENT\n PACKAGES",
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.bold),
        //           ))),
        //     ),
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //           height: 80,
        //           width: AppSceenSize.getWidth(context) * 0.3,
        //           decoration: BoxDecoration(
        //               color: Color(0xFf6C7380),
        //               borderRadius: BorderRadius.circular(5)),
        //           child: Center(
        //               child: Text(
        //             "SUBSCRIPTION \n & SPECIALS",
        //             style: TextStyle(
        //                 color: Colors.black, fontWeight: FontWeight.bold),
        //           ))),
        //     ),
        //   ],
        // ),

        SizedBox(
          height: 80,
          child: ListView.builder(
              itemCount: _services.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        height: 80,
                        width: AppSceenSize.getWidth(context) * 0.3,
                        decoration: BoxDecoration(
                            color: const Color(0xFf6C7380),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          _services[index],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))),
                  ),
                );
              }),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return OnboardingUpdate2();
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
                height: 150,
                width: AppSceenSize.getWidth(context),
                decoration: BoxDecoration(
                    color: const Color(0xFf6C7380),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  "Banner Will Come Here",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Frequently Asked Questions",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 200,
          child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ExpansionTile(
                    title: Text('Expandable Item'),
                    children: <Widget>[
                      ListTile(
                        title: Text('Subitem 1'),
                      ),
                      ListTile(
                        title: Text('Subitem 2'),
                      ),
                    ],
                  ),
                );
              }),
        ),

        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
