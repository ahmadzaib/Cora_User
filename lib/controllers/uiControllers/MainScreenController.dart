import 'dart:convert';

import 'package:coraapp/models/Auth/login_model.dart';
import 'package:get/get.dart';

import '../../utils/app_preferences.dart';

class MainScreenController extends GetxController {
  var userModel = LoginModel.fromMap({}).obs;

  @override
  void onInit() {
    super.onInit();

    var userMap = jsonDecode(
        globalPreferences?.getString(AppPreferences.USER_MODEL) ?? "{}");
    userModel.value = LoginModel.fromMap(userMap);
  }
}
