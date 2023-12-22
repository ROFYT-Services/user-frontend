import 'package:flutter/material.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/constant/app_text_style.dart';
import 'package:uber_pro_kolkata/view/rent_a_car/component/customer_detail.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeadingSection(),
            _buildProfileFormSection(),
            _buildButtonSection(),
          ],
        ),
      ),
    );
  }

  _buildHeadingSection() {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
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
        Image.asset("assets/icons/profileuser.png"),
        const Text(
          "Mrinmay",
          style: AppTextStyle.coupncodeText,
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "My Profile",
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }

  _buildProfileFormSection() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: AppSceenSize.getWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove default border
              hintText: 'Enter your text', // Placeholder text
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: AppSceenSize.getWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
          ),
          child: TextFormField(
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove default border
              hintText: 'Enter your text', // Placeholder text
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: AppSceenSize.getWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove default border
              hintText: '9187520040', // Placeholder text
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: AppSceenSize.getWidth(context),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: InputBorder.none, // Remove default border
              hintText: 'Dob', // Placeholder text
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildButtonSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0xFFF0C414),
                backgroundColor: const Color(0xFF0B327B), // Text color
                minimumSize: const Size(
                  double.infinity - 50,
                  50,
                ), // Full width button
              ),
              child: const Text("Upload Documents for approval")),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomerDetails();
            }));
          },
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Skip now>>  ",
                style: TextStyle(color: Color(0xFFF0C414)),
              )),
        )
      ],
    );
  }
}
