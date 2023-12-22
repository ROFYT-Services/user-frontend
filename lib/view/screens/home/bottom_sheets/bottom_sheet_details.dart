import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/view/screens/home/select_contact.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';

class ChooseOtherScreen extends StatefulWidget {
  final Function onSubmit;
  final Function changeName;

  const ChooseOtherScreen(
      {super.key, required this.onSubmit, required this.changeName});

  @override
  State<ChooseOtherScreen> createState() => _ChooseOtherScreenState();
}

class _ChooseOtherScreenState extends State<ChooseOtherScreen> {
  bool isMySelf = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Someone else taking this ride?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              "Choose a contact so that they also get driver number, vehicle details and ride OTP via SMS."),
          SizedBox(
            height: 10,
          ),
          RadioListTile(
            value: true,
            groupValue: isMySelf,
            onChanged: (val) {
              widget.changeName("MySelf");
              setState(() {
                isMySelf = true;
              });
            },
            title: Row(
              children: [
                Icon(Icons.person),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "MySelf",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () async {
              Contact? contact = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectContactUser(),
                  ));
              // final phones = contact.phones.map((e) => e.number).join(', ');
              // String userName = contact.displayName + " " + phones;
              if (contact != null) {
                CustomerProfile customerProvider =
                    Provider.of<CustomerProfile>(context, listen: false);
                customerProvider.setPhoneNumber(contact.phones[0].number);
                widget.changeName(contact.displayName);
                setState(() {
                  isMySelf = false;
                });
              }
            },
            title: Text(
              "Choose another contact",
              style: TextStyle(color: AppColor.appBlue),
            ),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
            leading: Icon(Icons.contact_phone_rounded, color: AppColor.appBlue),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () async {
                      widget.onSubmit(2);
                    },
                    child: Text(
                      'Skip',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      widget.onSubmit(2);
                    },
                    child: Text('Continue'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
