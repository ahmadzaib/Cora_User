import 'dart:convert';
import 'dart:io';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../controllers/applicationControllers/application_controller.dart';
import '../utils/constants.dart';
import '../utils/utils.dart';

class FcmService {
  static FcmService instance = FcmService._();

  Future<bool> askIOSPushMessagePermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      return true;
    }
    return false;
  }

  retrieveAnyPendingNotificationsPayload(){
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if(isNotEmpty(value)){
        FBroadcast.instance().broadcast(BroadcastEvent.EVENT_NAVIGATE_ORDER_DETAIL,    value: value!.data ?? {});
      }
    });
  }

  bindForgroundMessageListener(messageIntent) {
    if (Platform.isIOS) {
      askIOSPushMessagePermission();
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logMessage('Got a message whilst in the foreground!');
      showNotification(message);
    });
  }

  Future<String> getFCMToken() async {
    return (await FirebaseMessaging.instance.getToken()) ?? '';
  }

  Future<bool> initializeNotification(
      Function(NotificationResponse)? onTapNotification) async {
    var flutterLocalNotificationsPlugin =
        (Get.find<ApplicationController>()).flutterLocalNotificationsPlugin;
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher'); //@mipmap/ic_launcher
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification:
                (int id, String? title, String? body, String? payload) {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    return (await flutterLocalNotificationsPlugin?.initialize(
            initializationSettings,
            onDidReceiveNotificationResponse: onTapNotification)) ??
        false;
  }

  showNotification(RemoteMessage remoteMessage) async {
    var flutterLocalNotificationsPlugin =
        (Get.find<ApplicationController>()).flutterLocalNotificationsPlugin;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'high_importance_channel', 'your other channel name',
            channelDescription: 'your other channel description',
            priority: Priority.high);
    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin?.show(
        remoteMessage.hashCode,
        '${remoteMessage.data['title']}',
        '${remoteMessage.data['body']}',
        platformChannelSpecifics,
        payload: jsonEncode(remoteMessage.data));
  }

  FcmService._();
}
