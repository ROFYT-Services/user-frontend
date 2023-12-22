import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/models/coupon_model.dart';
import 'package:uber_pro_kolkata/utils/image_view.dart';
import 'package:uber_pro_kolkata/view_model/coupon_viewModel.dart';

class CouponCodeScreen extends StatefulWidget {
  const CouponCodeScreen({super.key});

  @override
  State<CouponCodeScreen> createState() => _CouponCodeScreenState();
}

class _CouponCodeScreenState extends State<CouponCodeScreen> {
  List<CouponModel> couponList = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    CouponViewModel couponProvider =
        Provider.of<CouponViewModel>(context, listen: false);
    await couponProvider.getCouponList(context);
    setState(() {
      couponList = couponProvider.couponList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color.fromARGB(0, 255, 193, 7),
        centerTitle: true,
        title: Text("Coupon Code"),
        backgroundColor: AppColor.AppThemecolor,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: couponList.length,
          itemBuilder: (context, index) {
            return buildCouponCard(index);
          }),
    );
  }

  Widget buildCouponCard(int index) {
    CouponModel model = couponList[index];
    String code = model.couponCode;
    String expiryDate = DateFormat("dd-MM-yy").format(model.expireDate);
    return Card(
      child: ListTile(
        leading: showImage(model.image),
        trailing: GestureDetector(
          onTap: () async {
            await Clipboard.setData(ClipboardData(text: code));
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Copied to clipboard'),
            ));
          },
          child: Icon(Icons.copy),
        ),
        title: Text(code),
        subtitle: Text("Valid till ${expiryDate}"),
      ),
    );
  }
}
