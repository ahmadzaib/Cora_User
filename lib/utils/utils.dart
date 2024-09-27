import 'dart:developer';
import 'dart:io';

import 'package:coraapp/models/Auth/login_model.dart';
import 'package:coraapp/service_locator.dart';
import 'package:coraapp/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_preferences.dart';
import 'constants.dart';

void logMessage(message) {
  if (kDebugMode) {
    log("####--->${message}");
  }
}

bool isNotEmpty(value) {
  if (value != null && value != '') {
    return true;
  }
  return false;
}

bool isEmpty(value) {
  if (value == null || value == '') {
    return true;
  }
  return false;
}

verticalSpace({
  double height = 10.0,
}) {
  return SizedBox(
    height: (height).toDouble(),
  );
}

horizontalSpace({double width = 10}) {
  return SizedBox(
    width: (width).toDouble(),
  );
}

String formatHHMMSS(int? seconds) {
  if (seconds != null && seconds != 0) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "${hoursStr}h:${minutesStr}m:${secondsStr}s";
  } else {
    return "00h:00m:00s";
  }
}

Future<bool> appHasInternetConnectivity() async =>
    await InternetConnectionChecker().hasConnection;

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}

void shareIntent({required String share}) {
  Share.share(share);
}

void logoutUser() async {
  globalPreferences?.setString(AppPreferences.ID_USER, '');
  globalPreferences?.setString(AppPreferences.TOKEN, '');
  // globalPreferences?.setString(AppPreferences.CLIENT, '');
  globalPreferences?.setString(AppPreferences.USER_MODEL, '');

  Get.offNamedUntil(NamedRoutes.routeLoginScreen, (route) => false);
}

showSnackBar(
  String errMsg,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(errMsg,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center),
      ],
    ),
    backgroundColor: blueAppColor,
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.down,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  ));
}

String formatDDHHMMSS(int seconds) {
  if (seconds != null && seconds != 0) {
    int days = (seconds / 86400).truncate();
    seconds = (seconds % 86400).truncate();
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();
    int sec = seconds % 60;

    String daysStr = (days).toString().padLeft(2, '0');
    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = sec.toString().padLeft(2, '0');

    return "${daysStr}d:${hoursStr}h:${minutesStr}m:${secondsStr}s";
  } else {
    return "00d:00h:00m:00s";
  }
}

String calculateDaysLeft(int seconds) {
  if (seconds != null && seconds != 0) {
    int days = (seconds / 86400).truncate();
    if (days > 0) {
      String daysStr = (days).toString();
      return "$daysStr ${days == 0 ? ('day') : ('days')}";
    } else {
      return ('Today');
    }
  } else {
    return "00d:00h:00m:00s";
  }
}

String formatDate(DateTime date, {format = "dd MMM yyyy"}) {
  return DateFormat(format).format(date);
}

DateTime parseDate(String date, {String format = "yyyy-MM-dd'T'HH:mm:ss"}) {
  if (isDate(date, format: format)) {
    return DateFormat(format).parse(date);
  } else {
    return DateTime.now();
  }
}

int calculateDifference(DateTime date) {
  DateTime now = DateTime.now();
  return DateTime(date.year, date.month, date.day)
      .difference(DateTime(now.year, now.month, now.day))
      .inDays;
}

bool isDate(String str, {String format = "yyyy-MM-dd'T'HH:mm:ss"}) {
  try {
    DateFormat(format).parse(str);
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> openLink(String url) async {
  Uri uri = Uri.parse(url);
  bool mode = false;
  try {
    mode = await launchUrl(uri);
    return mode;
  } catch (exc) {
    logMessage(exc.toString());
  }
  return mode;
}

String dayAndMonth(String date) {
  var formattedDate = DateFormat.MMMMEEEEd().format(DateTime.parse(date));
  return formattedDate;
}

String hourAndMinute(String date) {
  var formattedDate = DateFormat.jm().format(DateTime.parse(date));
  return formattedDate;
}
