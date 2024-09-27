import 'dart:async';

import 'package:coraapp/controllers/apiControllers/api_controller.dart';
import 'package:coraapp/controllers/applicationControllers/application_controller.dart';
import 'package:coraapp/models/PackageModel.dart';
import 'package:coraapp/utils/app_preferences.dart';
import 'package:coraapp/utils/colors.dart';
import 'package:coraapp/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/constants.dart';
import '../utils/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late APIController apiController;

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/applogo.png",
                height: 130,
                width: 130,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: whiteContainerColor,
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (isNotEmpty(globalPreferences?.getString(AppPreferences.TOKEN))) {
        Get.toNamed(NamedRoutes.routeHomeScreen);
      } else {
        Get.toNamed(NamedRoutes.routeLoginScreen);
      }
    });
    super.initState();

    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeSplashScreen);

    fetchCategories();

    apiController.baseModel.listen((baseModel) {
      if (baseModel.code == 'CATEGORIES') {
        Get.find<ApplicationController>().packageTypes =
            (baseModel.data as List)
                .map((package) => PackageModel.fromMap(package))
                .toList();
      }
    });
  }

  void fetchCategories() {
    apiController.webservice.apiCallPackageTypes({}, RxBool(false)).then(
        (value) => apiController.baseModel.value = value);
  }
}
