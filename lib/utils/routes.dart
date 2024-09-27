import 'package:coraapp/screen/contact_support_screen.dart';
import 'package:coraapp/screen/delivery_info_screen.dart';
import 'package:coraapp/screen/edit_profile_screen.dart';
import 'package:coraapp/screen/fund_wallet_screen.dart';
import 'package:coraapp/screen/home_screen.dart';
import 'package:coraapp/screen/login_screen.dart';
import 'package:coraapp/screen/menu_screen.dart';
import 'package:coraapp/screen/my_webview_flutter.dart';
import 'package:coraapp/screen/notification_screen.dart';
import 'package:coraapp/screen/otp_screen.dart';
import 'package:coraapp/screen/recent_delivery_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../screen/change_password_screen.dart';
import '../screen/delivery_detail_screen.dart';
import '../screen/forget_password_screen.dart';
import '../screen/get_free_delivery_screen.dart';
import '../screen/order_complete_screen.dart';
import '../screen/signup_screen.dart';
import '../screen/splash_screen.dart';
import '../screen/track_order_screen.dart';
import '../screen/track_rider_screen.dart';
import '../screen/track_your_order.dart';
import 'constants.dart';

class Routes {
  static var pages = [
    GetPage(
      name: NamedRoutes.routeMyWebview,
      page: () => MyWebViewFlutter(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeChangePassword,
      page: () => ChangePasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeOTP,
      page: () => OtpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeLoginScreen,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeHomeScreen,
      page: () => HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeTrackOrderScreen,
      page: () => TrackOrderScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeFundWalletScreen,
      page: () => FundWalletScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeDelievryDetailScreen,
      page: () => DeliveryDetailScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeTrackRiderScreen,
      page: () => TrackRiderScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeMenuScreen,
      page: () => MenuScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeEditProfileScreen,
      page: () => EditProfileScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeContactSupportScreen,
      page: () => ContactSupportScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeGetFreeDeliveryScreen,
      page: () => GetFreeDeliveryScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeDeliveryInfoScreen,
      page: () => DeliveryInfoScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeSignUpScreen,
      page: () => SignUpScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeForgetPasswordScreen,
      page: () => ForgetPasswordScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeNotificationScreen,
      page: () => NotificationScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeRecentDeliveryScreen,
      page: () => RecentDeliveryScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeTrackYourOrderScreen,
      page: () => TrackYourOderScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeSplashScreen,
      page: () => SplashScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: NamedRoutes.routeOrderCompleteScreen,
      page: () => OrderCompleteScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
