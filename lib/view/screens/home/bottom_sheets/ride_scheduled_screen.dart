import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';

class ScheduledConfirmRide extends StatelessWidget {
  final Function onSubmit;

  const ScheduledConfirmRide({super.key, required this.onSubmit});

  TextStyle get simpleText => TextStyle(fontSize: 16);

  TextStyle get boldText =>
      TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Ride Scheduled",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            "Your ride has been scheduled.Driver detail will be shared to you after some driver accept your request",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 25,
          ),
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
              child: Text('Got it.'),
            ),
          ),
        ],
      ),
    );
  }
}
