import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:uber_pro_kolkata/repository/payment_repo.dart';
import 'package:uber_pro_kolkata/utils/NavigationService.dart';
import 'package:uber_pro_kolkata/view/screens/rating/rating.dart';
import 'package:uber_pro_kolkata/web_socket/payment_socket.dart';

class RazorPayUtils {
  final _razorpay = Razorpay();
  static int tripId = -1;

  Future initRazorPay(int amt, int id) async {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    Map map = {"amount": amt * 100, "trip_id": id};
    tripId = id;
    await RazorPayRepo().createOrder(map);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    debugPrint("Payment SuccessFul");
    PaymentWebSocket().webSocketInit(tripId);
    PaymentWebSocket().addMessage();
    Navigator.push(
        NavigationService.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => RatingScreen(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    debugPrint("Payment Fail");
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    debugPrint("Wallet Started");
    // Do something when an external wallet is selected
  }

  createOrder(int amt) {
    var options = {
      'key': 'rzp_test_8pj00tLFpPjkIL',
      'amount': amt * 100,
      'name': 'Cab Driver',
      'order_id': RazorPayRepo.orderId,
      'description': 'Booking charges',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    _razorpay.open(options);
  }
}
