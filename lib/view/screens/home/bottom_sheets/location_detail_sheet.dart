import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/utils/utils.dart';
import 'package:uber_pro_kolkata/view/screens/home/select_contact.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';

class LocationDetailBottomSheet extends StatefulWidget {
  final Function onSubmit;
  final Function showSearchBar;

  const LocationDetailBottomSheet({
    super.key,
    required this.onSubmit,
    required this.showSearchBar,
  });

  @override
  State<LocationDetailBottomSheet> createState() =>
      _LocationDetailBottomSheetState();
}

class _LocationDetailBottomSheetState extends State<LocationDetailBottomSheet> {
  String startingLocation = "", endingLocation = "";
  int rideIndex = 0;
  String userName = "MySelf";
  String selectedPaymentMethod = "CASH";

  void setLocationData() {
    LocationProvider _provider = Provider.of<LocationProvider>(context);
    setState(() {
      startingLocation = _provider.pickUpText;
      endingLocation = _provider.destinationText;
    });
  }

  @override
  Widget build(BuildContext context) {
    setLocationData();
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: DropdownButton<String>(
                        value: selectedPaymentMethod,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (newValue) {
                          setState(() {
                            selectedPaymentMethod = newValue ?? "CASH";
                          });
                          LocationProvider _provider =
                              Provider.of<LocationProvider>(context,
                                  listen: false);
                          _provider.setPaymentMethod(selectedPaymentMethod);
                        },
                        items: <String>['CASH', 'WALLET', 'OTHERS']
                            .map<DropdownMenuItem<String>>((String value) {
                          IconData icon;
                          switch (value) {
                            case 'CASH':
                              icon = Icons.monetization_on_rounded;
                              break;
                            case 'WALLET':
                              icon = Icons.account_balance_wallet;
                              break;
                            case 'OTHERS':
                              icon = Icons.payment;
                              break;
                            default:
                              icon = Icons.money;
                          }
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(icon),
                                SizedBox(width: 8.0),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              customDivider(),
              Card(
                color: Colors.grey[400],
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      Contact? contact = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectContactUser(),
                          ));
                      if (contact != null) {
                        CustomerProfile customerProvider =
                            Provider.of<CustomerProfile>(context,
                                listen: false);
                        customerProvider
                            .setPhoneNumber(contact.phones[0].number);
                        setState(() {
                          userName = contact.displayName;
                        });
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person),
                        Text(
                          userName,
                          overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Icon(Icons.location_on, color: Colors.green)
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      widget.showSearchBar(true);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pick-up",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: AppSceenSize.getWidth(context) * 0.8,
                          child: Text(
                            startingLocation,
                            style: AppTextStyle.onboaringSubtitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.showSearchBar(false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Drop-off",
                          style: TextStyle(color: Color(0xFFC8C7CC)),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          width: AppSceenSize.getWidth(context) * 0.8,
                          child: Text(
                            endingLocation,
                            style: AppTextStyle.onboaringSubtitle,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     showIconText("Money", Icon(Icons.send), () {
          //       debugPrint("Money");
          //     }),
          //     customDivider(),
          //     showIconText("Coupons", Icon(Icons.tab_rounded), () {
          //       debugPrint("Coupons");
          //     }),
          //     customDivider(),
          //     showIconText("MySelf", Icon(Icons.person_2_outlined), () {
          //       debugPrint("MySelf");
          //     }),
          //   ],
          // ),
          const SizedBox(
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
                if (endingLocation == "Select the location") {
                  context.showErrorSnackBar(
                      message: "Please select drop-off location first");
                  return;
                }
                widget.onSubmit(1);
              },
              child: Text('Verify Now'),
            ),
          ),
        ],
      ),
    );
  }

  customDivider() {
    return Container(
      height: 40,
      color: Colors.grey[500],
      width: 2,
    );
  }

  Widget showIconText(String title, Icon icon, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 5,
            ),
            Text(title)
          ],
        ),
      ),
    );
  }
}
