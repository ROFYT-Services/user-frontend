import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/booking_car_details.dart';

import '../../../constant/app_asset_image.dart';

class BookingCar extends StatefulWidget {
  const BookingCar({Key? key}) : super(key: key);

  @override
  State<BookingCar> createState() => _BookingCarState();
}

class _BookingCarState extends State<BookingCar>
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Positioned(
              top: 20,
              child: Image.asset(
                AppAssetImage.bgstyle,
                width: AppSceenSize.getWidth(context),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [Icon(Icons.arrow_back), SizedBox()],
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppSceenSize.getHeight(context) * 0.30,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                            side: const BorderSide(
                              color: Colors.black, // Border color
                              width: 1, // Border width
                            ),
                          ),
                          child: const Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Price:low to high"),
                          ),
                          color: Colors.white,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                            side: BorderSide(
                              color: Colors.black, // Border color
                              width: 1, // Border width
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Price:low to high"),
                          ),
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingCarDetails(),
                          ));
                    },
                    child: Container(
                      width: AppSceenSize.getWidth(context) * 0.90,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppSceenSize.getWidth(context) * 0.05),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Maruti Swift (xl)",
                                style: AppTextStyle.carbookincarnametext,
                              ),
                              Text(
                                "5 Seater,Manual,Petrol",
                                style: AppTextStyle.subtextookincarnametext,
                              ),
                              Spacer(),
                              Text(
                                "\$2330",
                                style: AppTextStyle.carbookincarnametext,
                              ),
                              Text(
                                "For 120 kms with Fuel",
                                style: AppTextStyle.subtextookincarnametext,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/car.png",
                                width: 150,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingCarDetails(),
                        )),
                    child: Container(
                      width: AppSceenSize.getWidth(context) * 0.90,
                      margin: EdgeInsets.symmetric(
                          horizontal: AppSceenSize.getWidth(context) * 0.05),
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Maruti Swift (xl)",
                                style: AppTextStyle.carbookincarnametext,
                              ),
                              Text(
                                "5 Seater,Manual,Petrol",
                                style: AppTextStyle.subtextookincarnametext,
                              ),
                              Spacer(),
                              Text(
                                "\$2330",
                                style: AppTextStyle.carbookincarnametext,
                              ),
                              Text(
                                "For 120 kms with Fuel",
                                style: AppTextStyle.subtextookincarnametext,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/car1.png",
                                width: 150,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: AppSceenSize.getWidth(context) * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Color(0xFF28B910))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF29760E)),
                          child: Text(
                            "120 KMS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Text(
                            "240 KMS",
                            style: AppTextStyle.kmnametext,
                          ),
                        ),
                        Container(
                          child: Text(
                            "480 KMS",
                            style: AppTextStyle.kmnametext,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: AppSceenSize.getWidth(context) * 0.85,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Color(0xFF28B910))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Without Fuel",
                            style: AppTextStyle.withuorfueltext,
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Text(
                            "With Fuel",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
