import 'dart:convert';
import 'dart:developer';
import 'package:coraapp/service_locator.dart';
import 'package:coraapp/services/fcm_service.dart';
import 'package:coraapp/utils/colors.dart';
import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/routes.dart';
import 'package:coraapp/utils/utils.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/applicationControllers/application_controller.dart';
import 'firebase_options.dart';
import 'utils/app_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logMessage('Handling a background message:');
  await initialization();

  await FcmService.instance.showNotification(message);
}

void main() async {
  await initialization();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FBroadcast.instance().register(BroadcastEvent.EVENT_API_ERROR_HANDLING,
      (value, callback) {
    if (isNotEmpty(value)) {
      if (value is Map) {
        var statusCode = value['statusCode'];
        var errMsg = value['errMsg'];
        if (statusCode == 401) {
          Future.delayed(Duration(seconds: 1), () {
            logoutUser();
          });
        } else {
          print('is called $errMsg');
          myScaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(errMsg,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center),
              ],
            ),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ));
        }
      }
    }
  });
  await setupLocator();
  _setupLogging();
  runApp(const MyApp());
}

Future<void> initialization() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    globalPreferences = await SharedPreferences.getInstance();
    Get.put(ApplicationController());

    await FcmService.instance.initializeNotification((value) {
      logMessage('Notification Response--->${value.payload}');
      var orderID = (jsonDecode(value.payload ?? '{}'))['order_id'].toString();
      Get.toNamed(NamedRoutes.routeOrderCompleteScreen,
          arguments: {'order_id': int.tryParse(orderID) ?? 0});
    });
    logMessage("FCM#Token#-->${await FcmService.instance.getFCMToken()}");
    Clipboard.setData(
        ClipboardData(text: await FcmService.instance.getFCMToken()));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } catch (e) {
    log('Error in initialization $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: myScaffoldKey,
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: false,
      title: 'Cora Ride User',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        primarySwatch: appBarColorSwatch,
        scaffoldBackgroundColor: const Color(0xFFEFEFEF),
      ),
      initialRoute: NamedRoutes.routeSplashScreen,
      getPages: Routes.pages,
    );
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    // print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

// class SnackBarHere extends StatelessWidget {
//   SnackBarHere({super.key, required this.errMsg});
//   String errMsg;
//   @override
//   Widget build(BuildContext context) {
//     return showSnackBar(errMsg, context);
//   }
// }
