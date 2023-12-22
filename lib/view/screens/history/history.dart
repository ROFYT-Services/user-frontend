import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/trip_model.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/view/screens/history/ride_detail_screen.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TripModel> tripList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    TripViewModel _provider =
        Provider.of<TripViewModel>(context, listen: false);
    if (_provider.tripList.isEmpty) await _provider.getTrips(context);
    List<TripModel> list = _provider.tripList;
    setState(() {
      tripList = list;
    });
  }

  void readData() async {
    TripViewModel _provider = Provider.of<TripViewModel>(context, listen: true);
    List<TripModel> list = _provider.tripList;
    setState(() {
      tripList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.AppThemecolor,
        title: Text("History"),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: tripList.length,
          itemBuilder: (context, index) {
            return buildHistoryCard(index);
          }),
    );
  }

  Widget buildHistoryCard(int index) {
    TripModel tripData = tripList[index];
    DateTime now = DateTime.parse(tripData.timing);
    String formattedDate = DateFormat('dd-MM-yyyy , h:mm a').format(now);

    return GestureDetector(
      onTap: () {
        if (tripData.status == "ACCEPTED" ||
            tripData.status == "ON_TRIP" ||
            tripData.status == "COMPLETED" ||
            tripData.status == "BOOKED" ||
            tripData.status == "SCHEDULED") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  RideDetailScreen(tripData: tripData, index: index)));
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: AppSceenSize.getWidth(context) * 0.94,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.car_repair),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                          "${tripData.distance} KM || ${tripData.cabData.modelText} || ${tripData.cabData.numberplate}"),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Image.asset("assets/icons/Oval.png",
                              width: 10, fit: BoxFit.fill),
                          SizedBox(width: 10),
                          SizedBox(
                            width: AppSceenSize.getWidth(context) * 0.5,
                            child: Text(tripData.source,
                                style: AppTextStyle.historytext),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Image.asset("assets/icons/map.png",
                              width: 10, fit: BoxFit.fill),
                          SizedBox(width: 14),
                          SizedBox(
                            width: AppSceenSize.getWidth(context) * 0.5,
                            child: Text(tripData.destination,
                                style: AppTextStyle.historytext),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    tripData.status,
                    style: TextStyle(
                        color: (tripData.status == "REJECTED" ||
                                tripData.status == "CANCELLED")
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  showImage(tripData.driverProfilePic),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
