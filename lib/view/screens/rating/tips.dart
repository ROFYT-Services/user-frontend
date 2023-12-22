import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/models/trip_model.dart';
import 'package:uber_pro_kolkata/repository/payment_repo.dart';
import 'package:uber_pro_kolkata/services/razor_pay.dart';
import 'package:uber_pro_kolkata/view/screens/rating/rating.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';

class TipsScreen extends StatefulWidget {
  const TipsScreen({super.key});

  @override
  State<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends State<TipsScreen> {
  // int tipIndex = 0;

  TripModel? model;
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    TripViewModel provider = Provider.of<TripViewModel>(context, listen: false);

    RazorPayUtils razor = RazorPayUtils();

    int amt = (provider.currentTrip?.amount ?? 0);
    await razor.initRazorPay(amt, provider.currentTrip?.id ?? 297);
    setState(() {
      model = provider.currentTrip!;
      imageUrl = RazorPayRepo.qrImage;
    });
  }

  Widget paymentShowView() {
    if (model == null) {
      return Center(child: CircularProgressIndicator());
    }
    TextStyle style = TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold);
    if (model!.paymentMode == "QR_CODE") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Please pay the money to driver using UPI or Cash.",
          style: style,
        ),
      );
      // return Image.network(
      //   imageUrl, width: 250,
      //   height: 500,
      //   fit: BoxFit.fill, // You can adjust the fit as needed
      // );
    } else if (model!.paymentMode == "WALLET") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Your Money has been debited from your wallet. Please click Continue to proceed further",
          style: style,
        ),
      );
    } else if (model!.paymentMode == "OTHERS") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "Please Click Pay button to pay the ride Amount. Thank you for riding with us.\n Hope to see you again soon",
          style: style,
        ),
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    // readData();

    return Scaffold(
        backgroundColor: AppColor.AppThemecolor,
        appBar: AppBar(
          shadowColor: Color.fromARGB(0, 255, 193, 7),
          centerTitle: true,
          backgroundColor: AppColor.AppThemecolor,
          title: Text("Payment"),
        ),
        body: Container(
          height: AppSceenSize.getHeight(context) * 0.75,
          width: AppSceenSize.getWidth(context) * 0.90,
          margin: EdgeInsets.only(
              left: AppSceenSize.getWidth(context) * 0.05,
              top: AppSceenSize.getHeight(context) * 0.05),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              paymentShowView(),
              SizedBox(height: 10.0),
              Container(
                width: AppSceenSize.getWidth(context) * 0.90,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF28B910),
                  ),
                  onPressed: () async {
                    RazorPayUtils razor = RazorPayUtils();

                    if (model!.paymentMode == "OTHERS") {
                      await razor.createOrder(model?.amount ?? 100);
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RatingScreen(),
                        ));

                    // RazorPayUtils razor = RazorPayUtils();
                    // TripViewModel _tripViewModel =
                    //     Provider.of<TripViewModel>(context,
                    //         listen: false);
                    //
                    // int amt = (_tripViewModel.currentTrip?.amount ?? 0);
                    // int tip = 0;
                    // if (tipIndex == 0)
                    //   tip += 10;
                    // else if (tipIndex == 1)
                    //   tip += 20;
                    // else if (tipIndex == 2) tip += 50;
                    //
                    // CustomerProfile provider =
                    //     Provider.of<CustomerProfile>(context,
                    //         listen: false);
                    // double percentage =
                    //     provider.currCustomerProfile?.cabDiscount ??
                    //         0.0;
                    // percentage = min(1.0, percentage);
                    // int discount = (amt * percentage).toInt();
                    // amt = amt - discount;
                    // await razor.initRazorPay(amt + tip,
                    //     _tripViewModel.currentTrip?.id ?? 297);
                    // razor.createOrder(amt + tip);
                  },
                  child: Text('Pay'),
                ),
              ),
            ],
          ),
        ));
  }
}
