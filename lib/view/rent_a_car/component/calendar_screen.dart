import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
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
              SizedBox(
                height: 10,
              ),
              _buildText(),
              SizedBox(
                height: 20,
              ),
              _builDateContainer(),
              SizedBox(
                height: 20,
              ),
              _buildCalendarSection(),
            ],
          ),
        ),
      ),
    );
  }

  _buildText() {
    return GestureDetector(
      onTap: () {},
      child: Container(
          height: 30,
          width: AppSceenSize.getWidth(context) * 0.85,
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
    );
  }

  _buildCalendarSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Selected Date:',
        //   style: TextStyle(fontSize: 20),
        // ),
        // SizedBox(height: 10),
        // Text(
        //   _selectedDate.toString(),
        //   style: TextStyle(fontSize: 18),
        // ),
        // SizedBox(height: 20),
        TableCalendar(
          firstDay: DateTime(2000),
          lastDay: DateTime(2101),
          focusedDay: _selectedDate,
          selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
            });
          },
        ),

        SizedBox(
          height: 10,
        ),

        Divider(
          color: Colors.green,
          thickness: 2,
        ),

        SizedBox(
          height: 10,
        ),

        Text(
          " Pick up Time",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 150.0),
          child: Container(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 3,
                  color: Color(0xFF0FF241),
                ),
                Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Color(0xFfD7AF0F),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    '2:30 PM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  _builDateContainer() {
    return Container(
        width: AppSceenSize.getWidth(context) * 0.85,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Color(0xFF28B910))),
        child: Center(
            child: Text(
          "Mon, 31 jul 2023, 02:30 PM",
          style: TextStyle(fontWeight: FontWeight.bold),
        )));
  }
}
