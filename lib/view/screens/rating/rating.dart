import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/models/trip_model.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/view/screens/splash/splash.dart';
import 'package:uber_pro_kolkata/view_model/rating_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  TextEditingController controller = TextEditingController();
  int selectedRating = 0;
  TripModel? model;

  void readData() {
    TripViewModel customerProvider =
        Provider.of<TripViewModel>(context, listen: false);
    setState(() {
      model = customerProvider.currentTrip!;
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Scaffold(
        backgroundColor: AppColor.AppThemecolor,
        appBar: AppBar(
          shadowColor: Color.fromARGB(0, 255, 193, 7),
          centerTitle: true,
          backgroundColor: AppColor.AppThemecolor,
          title: Text("Rating"),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  height: AppSceenSize.getHeight(context) * 0.70,
                  width: AppSceenSize.getWidth(context) * 0.90,
                  margin: EdgeInsets.only(
                      left: AppSceenSize.getWidth(context) * 0.05,
                      top: AppSceenSize.getHeight(context) * 0.15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        model?.cabData.cabTypeText ?? "Car",
                        style: AppTextStyle.ratingnametext,
                      ),
                      // Text(
                      //   "000000",
                      //   style: AppTextStyle.ratingsubtext,
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "How is your trip?",
                        style: AppTextStyle.ratingtatletext,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Your feedback will help improve driving experience",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRating = i;
                                });
                              },
                              child: Icon(
                                Icons.star,
                                color: i <= selectedRating
                                    ? Colors.yellow
                                    : Color(0xFFEFEFF4),
                                size: 50.0,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          autofocus: false,
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Enter your comment...',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 10),
                            border: InputBorder.none,
                            fillColor: Color(0xFFEFEFF2),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        width: AppSceenSize.getWidth(context) * 0.90,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF28B910),
                          ),
                          onPressed: () async {
                            TripViewModel tripViewModel =
                                Provider.of<TripViewModel>(context,
                                    listen: false);

                            Map<String, dynamic> map = {
                              "star": selectedRating,
                              "feedback": controller.text,
                              "trip": tripViewModel.currentTrip?.id ?? 109,
                            };
                            RatingViewModel viewModel =
                                Provider.of<RatingViewModel>(context,
                                    listen: false);
                            await viewModel.giveRating(context, map);

                            Navigator.of(context).popUntil((route) {
                              return false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SplashScreen(),
                                ));
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: AppSceenSize.getHeight(context) * 0.09,
                  left: AppSceenSize.getWidth(context) * 0.36,
                  child: showImage(model?.driverProfilePic ?? "")),
            ],
          ),
        ));
  }
}
