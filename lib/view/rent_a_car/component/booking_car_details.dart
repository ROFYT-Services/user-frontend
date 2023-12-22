import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';

class BookingCarDetails extends StatefulWidget {
  const BookingCarDetails({Key? key}) : super(key: key);

  @override
  _BookingCarDetailsState createState() => _BookingCarDetailsState();
}

class _BookingCarDetailsState extends State<BookingCarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildFirstCardSection(),
              _buildSecondCardSection(),
              _buildThirdCardSection(),
              _buildForthCardSection()
            ],
          ),
        ),
      ),
    );
  }

  _buildFirstCardSection() {
    return Column(
      children: [
        SizedBox(height: 20),
        GestureDetector(
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
        Container(
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.symmetric(
            horizontal: AppSceenSize.getWidth(context) * 0.05,
          ),
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
                  SizedBox(height: 5),
                  Text(
                    "Maruti Swift (xl)",
                    style: AppTextStyle.carbookincarnametext,
                  ),
                  Text(
                    "5 Seater, Manual, Petrol",
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
                  SizedBox(height: 10),
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
        SizedBox(height: 30),
      ],
    );
  }

  _buildSecondCardSection() {
    return Column(
      children: [
        Container(
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.symmetric(
            horizontal: AppSceenSize.getWidth(context) * 0.05,
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          height: 160,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      SizedBox(
                        width: AppSceenSize.getWidth(context) * 0.50,
                        child: Text(
                          " Drive, Bengaluru, Bengaluru Tuesday, August 1, 2023, 02:30 PM",
                          style: AppTextStyle.subtextookincarnametext,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.location_on),
                      SizedBox(width: 10),
                      SizedBox(
                        width: AppSceenSize.getWidth(context) * 0.50,
                        child: Text(
                          " Drive, Hyderabad, Hyderabad Wednesday, August 2, 2023, 02:30 PM",
                          style: AppTextStyle.subtextookincarnametext,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "CHANGE",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 30),
        Container(
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.symmetric(
            horizontal: AppSceenSize.getWidth(context) * 0.05,
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
          height: 230,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Price Details", style: AppTextStyle.carbookincarnametext),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Manual, Petrol",
                        style: AppTextStyle.subtextookincarnametext),
                    Text("2330"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Different location Charge",
                        style: AppTextStyle.subtextookincarnametext),
                    Text("10000"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tax", style: AppTextStyle.subtextookincarnametext),
                    Text("3452"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: AppTextStyle.subtextookincarnametext),
                    Text("15782"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" + Refundable Deposit",
                        style: AppTextStyle.refundnametext),
                    Text("5000", style: AppTextStyle.refundnametext),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildThirdCardSection() {
    return Column(
      children: [
        Container(
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.symmetric(
            horizontal: AppSceenSize.getWidth(context) * 0.05,
          ),
          padding: EdgeInsets.symmetric(vertical: 5),
          height: 90,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        SizedBox(
                          width: AppSceenSize.getWidth(context) * 0.50,
                          child: Text(
                            "20,782",
                            style: AppTextStyle.coupncodeText,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text("For 120 kms with Fuel")
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apply Coupon",
                      style: AppTextStyle.applycoupnText,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  _buildForthCardSection() {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _showBookSuccessfullDialog();
          },
          child: Container(
              height: 40,
              width: AppSceenSize.getWidth(context) * 0.6,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: const Center(
                  child: Text(
                "Proceed to Pay",
                style: TextStyle(color: Color(0xFf4BFB0E), fontSize: 20),
              ))),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void _showBookSuccessfullDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Image.asset("assets/icons/check.png"),
              const SizedBox(
                height: 7,
              ),
              const Text('Booking Successful'),
            ],
          ),
          content: const Text('Your booking has been confirmed'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }
}
