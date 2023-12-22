import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/constant/app_color.dart';
import 'package:uber_pro_kolkata/constant/app_screen_size.dart';
import 'package:uber_pro_kolkata/view_model/coupon_viewModel.dart';

class PromoCodeScreen extends StatefulWidget {
  final Function onSubmit;

  const PromoCodeScreen({super.key, required this.onSubmit});

  @override
  State<PromoCodeScreen> createState() => _PromoCodeScreenState();
}

class _PromoCodeScreenState extends State<PromoCodeScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "Coupon Code",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.shade200,
                ), // Customize the border color here
                borderRadius: BorderRadius.circular(8.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
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
                if (controller.text.isNotEmpty) {
                  CouponViewModel couponProvider =
                      Provider.of<CouponViewModel>(context, listen: false);
                  Map map = {
                    "": controller.text,
                  };
                  await couponProvider.couponStatusCheck(context, map);
                }

                widget.onSubmit(4);
              },
              child: Text('Apply Coupon'),
            ),
          ),
        ],
      ),
    );
  }
}
