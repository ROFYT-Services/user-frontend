import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';

class SelectDateTimeScreen extends StatefulWidget {
  final Function onSubmit;

  const SelectDateTimeScreen({super.key, required this.onSubmit});

  @override
  State<SelectDateTimeScreen> createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  TextStyle get simpleText => TextStyle(fontSize: 16);

  String selectedDate = "";
  String selectedTime = "";
  TimeOfDay pickedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    selectedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    selectedTime = DateFormat('h:mm a').format(
      DateTime(0, 1, 1, TimeOfDay.now().hour, TimeOfDay.now().minute),
    );
  }

  customDivider() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 10,
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Pick-Up Date & Time",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          customDivider(),
          GestureDetector(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(), // The earliest selectable date
                lastDate: DateTime(2101), // The latest selectable date
              );

              if (picked != null) {
                String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
                setState(() {
                  selectedDate = formattedDate;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Date :- ",
                  style: simpleText,
                ),
                Text(
                  selectedDate,
                  style: simpleText,
                ),
              ],
            ),
          ),
          customDivider(),
          GestureDetector(
            onTap: () async {
              TimeOfDay currentTime =
                  TimeOfDay.now(); // Initialize with the current time

              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: currentTime,
              );

              if (picked != null) {
                pickedTime = picked;
                String formattedTime = DateFormat('h:mm a').format(
                  DateTime(0, 1, 1, picked.hour, picked.minute),
                );
                setState(() {
                  selectedTime = formattedTime;
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Time :- ",
                  style: simpleText,
                ),
                Text(
                  selectedTime,
                  style: simpleText,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            width: AppSceenSize.getWidth(context) * 0.90,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.btncoloryellow),
              ),
              onPressed: () async {
                debugPrint(
                    "$selectedDate ${pickedTime.hour}:${pickedTime.minute}");
                final format = DateFormat("dd-MM-yyyy HH:mm:ss");

                LocationProvider _provider =
                    Provider.of<LocationProvider>(context, listen: false);

                DateTime dateTime = format.parse(
                    "$selectedDate ${pickedTime.hour}:${pickedTime.minute}:00");
                _provider.setscheduleTime(dateTime);
                widget.onSubmit(3);
              },
              child: Text('Book Now'),
            ),
          ),
        ],
      ),
    );
  }
}
