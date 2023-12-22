import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/booking_car.dart';

class ChoosePickupLocation extends StatefulWidget {
  const ChoosePickupLocation({super.key});

  @override
  State<ChoosePickupLocation> createState() => _ChoosePickupLocationState();
}

class _ChoosePickupLocationState extends State<ChoosePickupLocation> {
  List cityname = [
    {'cityname': "Bangalore", 'cityicon': "assets/icons/cityicon.png"},
    {'cityname': "Calicut", 'cityicon': "assets/icons/cityicon.png"},
    {'cityname': "Chennai", 'cityicon': "assets/icons/cityicon.png"},
    {'cityname': "Cochin", 'cityicon': "assets/icons/cityicon.png"},
    {'cityname': "Hyderabad", 'cityicon': "assets/icons/cityicon.png"},
    {'cityname': "Trivandrum", 'cityicon': "assets/icons/cityicon.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_back_ios),
                Text(
                  "Choose pick up city",
                  style: AppTextStyle.appBarTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: AppSceenSize.getHeight(context) * 0.40,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns in the grid
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 10.0, // Spacing between columns
              ),
              itemCount: 6, // Total number of items in the grid
              itemBuilder: (BuildContext context, index) {
                // This function builds each grid item
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        height: 40,
                        width: AppSceenSize.getWidth(context) * 0.3,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFfADB507), width: 2),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(cityname[index]['cityicon']),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              cityname[index]['cityname'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Our Location in Kolkata",
                    style: AppTextStyle.locationTextStyle,
                  )),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    side: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    ),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Spacer(),
                      Text('Click Me'),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF4165A7),
                    elevation: 0,
                    side: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    ),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on),
                      Spacer(),
                      Text('Kolkata Air port'),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFF242E42AB),
                    elevation: 0,
                    side: BorderSide(
                      width: 1,
                      color: Colors.blue,
                    ),
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      Text('My Ride kolkata'),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            width: 100,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BookingCar();
                }));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Color(0xFF242E42AB),
                elevation: 0,
                side: const BorderSide(
                  width: 1,
                  color: Colors.blue,
                ),
                minimumSize: Size(double.infinity, 50),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
              child: Row(
                children: const [
                  Spacer(),
                  Text('NEXT'),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
