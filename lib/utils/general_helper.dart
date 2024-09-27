import 'package:flutter/material.dart';

Future<void> delayFunction({int? miliseconds = 100}) async {
  await Future.delayed(Duration(milliseconds: miliseconds ?? 100), () {
    // Do something
  });
}

dynamic modalRouteHandler(BuildContext context) {
  final modalRoute = ModalRoute.of(context);

  dynamic routeData;
  if (modalRoute == null) {
    Navigator.of(context).pop();
  } else {
    final routeArguments = modalRoute.settings.arguments;
    if (routeArguments == null) {
      Navigator.of(context).pop();
    } else {
      routeData = routeArguments;
    }
  }
  return routeData;
}
