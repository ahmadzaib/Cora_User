import 'package:coraapp/models/PackageModel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class ApplicationController extends GetxController {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // var userSettings = <UserSettingsModel>[].obs;
  var packageTypes = <PackageModel>[];
  var visibleWallet = true.obs;
}
