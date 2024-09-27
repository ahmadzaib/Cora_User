import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? globalPreferences = null;

class AppPreferences {
  static const String ID_USER = "ID_USER";
  static const String TOKEN = "TOKEN";
  static const String USER_MODEL = "USER_MODEL";

  AppPreferences._();
}