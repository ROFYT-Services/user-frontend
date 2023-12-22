import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uber_pro_kolkata/utils/NavigationService.dart';
import 'package:uber_pro_kolkata/utils/local_notification.dart';
import 'package:uber_pro_kolkata/view/screens/splash/splash.dart';
import 'package:uber_pro_kolkata/view_model/choose_vehicle_type.dart';
import 'package:uber_pro_kolkata/view_model/coupon_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/customerprofile_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/driver_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/location_provider.dart';
import 'package:uber_pro_kolkata/view_model/message_viewmodel.dart';
import 'package:uber_pro_kolkata/view_model/rating_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/signIn_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/trip_viewModel.dart';
import 'package:uber_pro_kolkata/view_model/vehicle_viewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService().init();
  runApp(const MyUberProApp());
}

class MyUberProApp extends StatelessWidget {
  const MyUberProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ChooseVehicleViewModel()),
        ChangeNotifierProvider(create: (context) => SignInViewModel()),
        ChangeNotifierProvider(create: (context) => TripViewModel()),
        ChangeNotifierProvider(create: (context) => CustomerProfile()),
        ChangeNotifierProvider(create: (context) => RatingViewModel()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => DriverViewModel()),
        ChangeNotifierProvider(create: (context) => VehicleViewModel()),
        ChangeNotifierProvider(create: (context) => MessageViewModel()),
        ChangeNotifierProvider(create: (context) => CouponViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // home: LocationSelectionScreen(),
      ),
    );
  }
}
