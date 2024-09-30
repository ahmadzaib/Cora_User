// ignore_for_file: prefer_final_fields

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class APIEndpoints {
  static String BASE_URL = 'https://admin.usecora.com/api/';
  static String BASE_MAPS_URL = 'https://maps.googleapis.com';

  static String LOGIN = '${BASE_URL}login';
  static String REGISTER = '${BASE_URL}register';
  static String PLACE_ORDER = '${BASE_URL}place-order';
  static String UPLOAD_IMAGE = '${BASE_URL}upload-image';
  static String CALCULATE_DISTANCE = '${BASE_URL}distance-calculate';
  static String ORDERS = '${BASE_URL}orders';
  static String UPDATE_PROFILE = '${BASE_URL}update-profile';
  static String GET_PROFILE = '${BASE_URL}get-profile';
  static String HOME = '${BASE_URL}home';
  static String SPECIFIC_ORDER = '${BASE_URL}order';
  static String REVIEW_POST = '${BASE_URL}post-review';
  static String PACKAGE_TYPES = '${BASE_URL}categories';
  static String VALIDATE_COUPON = '${BASE_URL}validate-coupon';
  static String SAVE_CARD = '${BASE_URL}save-card';
  static String FUND_WALLET = '${BASE_URL}add-wallet';
  static String FORGET_PASSWORD = '${BASE_URL}forgot-password';
  static String TRACK_ORDER = '${BASE_URL}track-order';
  static String NOTIFICATIONS = '${BASE_URL}notifications';
  static String RATINGALLOWED = '${BASE_URL}allowed-rating';
  static String PAY_WITH_PAYSTACK = '${BASE_URL}pay';
  static String VERIFY_TRANSACTION_PAYSTACK = '${BASE_URL}verify-transaction';

  static String PLACE_SUGGESTION =
      '${BASE_MAPS_URL}/maps/api/place/autocomplete/json';
  static String REVERSE_GEOCODING = '${BASE_MAPS_URL}/maps/api/geocode/json';

  APIEndpoints._();
}

class AppSecureInformation {
  // static String MAPS_API_KEY = 'AIzaSyAd8Huk4y_-3pj5ZqIrb8lhkwA_ZP9nX1M';
  static String MAPS_API_KEY = 'AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k';

  AppSecureInformation._();
}

class UserAuth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static User? _user = _auth.currentUser;

  // get private user
  static User? get user => _user;

  // get private auth
  static FirebaseAuth get auth => _auth;

  // There isn’t a setter named 'user' in class 'UserAuth'.
  static set user(User? user) => _user = user;

  UserAuth._();
}

class BroadcastEvent {
  static String EVENT_API_ERROR_HANDLING = 'EVENT_API_ERROR_HANDLING';
  static String EVENT_REFRESH_API = 'EVENT_REFRESH_API';
  static String EVENT_NAVIGATE_ORDER_DETAIL =
      'EVENT_NAVIGATE_ORDER_DETAIL_CUSTOMER';

  BroadcastEvent._();
}

var myScaffoldKey = GlobalKey<ScaffoldMessengerState>(
  debugLabel: 'myScaffoldKey',
);

class NamedRoutes {
  static String routeLoginScreen = '/routeLoginScreen';
  static String routeHomeScreen = '/routeHomeScreen';
  static String routeTrackOrderScreen = '/routeTrackOrderScreen';
  static String routeFundWalletScreen = '/routeFundWalletScreen';
  static String routeDelievryDetailScreen = '/routeDelievryDetailScreen';
  static String routeTrackRiderScreen = '/routeTrackRiderScreen';
  static String routeMenuScreen = '/routeMenuScreen';
  static String routeEditProfileScreen = '/routeEditProfileScreen';
  static String routeContactSupportScreen = '/routeContactSupportScreen';
  static String routeGetFreeDeliveryScreen = '/routeGetFreeDeliveryScreen';
  static String routeDeliveryInfoScreen = '/routeDeliveryInfoScreen';
  static String routeSignUpScreen = '/routeSignUpScreen';
  static String routeForgetPasswordScreen = '/routeForgetPasswordScreen';
  static String routeNotificationScreen = '/routeNotificationScreen';
  static String routeRecentDeliveryScreen = '/routeRecentDeliveryScreen';
  static String routeTrackYourOrderScreen = '/routeTrackYourOrderScreen';
  static String routeSplashScreen = '/routeSplashScreen';
  static String routeOrderCompleteScreen = '/routeOrderCompleteScreen';
  static const String routeOTP = '/routeOTP';
  static String routeChangePassword = '/routeChangePassword';
  static String routeMyWebview = '/routeMyWebview';
}
