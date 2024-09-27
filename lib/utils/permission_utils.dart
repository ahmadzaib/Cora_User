import 'package:coraapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'constants.dart';

class PermissionUtils {
  static Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      myScaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'You denied location services permanently. Please visit app settings & enable it again.',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center),
          ],
        ),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ));
      return false;
    }
    return true;
  }

  PermissionUtils._();
}
