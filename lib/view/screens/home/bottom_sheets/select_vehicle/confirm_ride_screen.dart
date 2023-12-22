import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';

class ConfirmVehicleScreen extends StatelessWidget {
  final Function onSubmit;

  const ConfirmVehicleScreen({super.key, required this.onSubmit});

  TextStyle get simpleText => TextStyle(fontSize: 16);

  TextStyle get boldText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total fare",
                    style: boldText,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Includes taxes", style: simpleText),
                  SizedBox(
                    height: 5,
                  ),
                  Text("View details",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(
                "₹ 883",
                style: boldText,
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Our Fleet", style: boldText),
              Text(
                "COMFORT",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              )
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Image.asset(
            "assets/icons/cars.png",
            width: 150,
            height: 50,
          ),
          SizedBox(
            height: 25,
          ),
          Text("Tyaoto Novoa, Maruti Ertnga, Tata Nexon", style: simpleText),
          Container(
            width: AppSceenSize.getWidth(context) * 0.90,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.btncoloryellow),
              ),
              onPressed: () async {
                onSubmit(0);
              },
              child: Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
