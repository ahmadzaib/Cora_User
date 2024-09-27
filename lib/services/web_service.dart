import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../models/baseModel/base_model.dart';
import '../utils/app_preferences.dart';
import '../utils/constants.dart';
import '../utils/handlers.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class Webservice {
  static final Webservice _singleton = Webservice._internal();

  factory Webservice() {
    return _singleton;
  }

  Webservice._internal();

  Map<String, String> appHeaders({isImage = false}) {
    Map<String, String> headers;
    if (isImage) {
      headers = {
        "accept": "*/*",
        "Content-Type": "multipart/form-data",
      };
    } else {
      if (isNotEmpty(globalPreferences?.getString(AppPreferences.TOKEN))) {
        var token = globalPreferences?.getString(AppPreferences.TOKEN);
        log('${globalPreferences?.getString(AppPreferences.ID_USER)}');
        headers = {
          "accept": "*/*",
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        };
      } else {
        headers = {
          "accept": "*/*",
          "Content-Type": "application/json",
        };
      }
    }
    return headers;
  }

  Future<BaseModel> apiCallLogin(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      var uri = Uri.parse(APIEndpoints.LOGIN);

      try {
        // Use the CustomHttpClient to make the request
        final response = await CustomHttpClient.post(
            uri,
            {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            jsonEncode(jsonMap));

        isLoading.value = false;

        logMessage('Response status: ${response.statusCode}');
        logMessage('Response body: ${response.body}');

        if (response.statusCode == 200) {
          var responseMap = jsonDecode(response.body);
          return BaseModel.fromMap(responseMap);
        } else {
          Handlers().apiResponseHandler(response);
          return BaseModel.fromMap(null);
        }
      } catch (e) {
        isLoading.value = false; // Ensure loading state is updated
        logMessage('Error during API call: $e');

        // Check if the response is null before accessing its properties
        if (e is HandshakeException) {
          // Handle specific handshake exception if needed
          logMessage('SSL Handshake Exception: $e');
        } else {
          Handlers().apiResponseHandler(null, hasConnectivity: true);
        }

        return BaseModel.fromMap(null);
      }
    } else {
      logMessage('No internet connectivity');
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFundWallet(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.FUND_WALLET).scheme,
        host: Uri.parse(APIEndpoints.FUND_WALLET).host,
        path: Uri.parse(APIEndpoints.FUND_WALLET).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallSaveCard(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.SAVE_CARD).scheme,
        host: Uri.parse(APIEndpoints.SAVE_CARD).host,
        path: Uri.parse(APIEndpoints.SAVE_CARD).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallPlaceOrder(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.PLACE_ORDER).scheme,
        host: Uri.parse(APIEndpoints.PLACE_ORDER).host,
        path: Uri.parse(APIEndpoints.PLACE_ORDER).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallUpdateProfile(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.UPDATE_PROFILE).scheme,
        host: Uri.parse(APIEndpoints.UPDATE_PROFILE).host,
        path: Uri.parse(APIEndpoints.UPDATE_PROFILE).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallCalculateDistance(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.CALCULATE_DISTANCE).scheme,
        host: Uri.parse(APIEndpoints.CALCULATE_DISTANCE).host,
        path: Uri.parse(APIEndpoints.CALCULATE_DISTANCE).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  // make multipart request
  Future<BaseModel> apiCallUploadImage(File imagePath, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders(isImage: true);

      var uri = Uri.parse(
        APIEndpoints.UPLOAD_IMAGE,
      );

      var request = MultipartRequest(
        'POST',
        uri,
      );
      request.headers.addAll(headers);
      request.fields['id'] =
          '${globalPreferences?.getString(AppPreferences.ID_USER) ?? ''}';
      request.files.add(http.MultipartFile(
          'image', imagePath.readAsBytes().asStream(), imagePath.lengthSync(),
          filename: imagePath.path.split("/").last));
      var response = await request.send();
      var data = await http.Response.fromStream(response);
      isLoading.value = false;
      logMessage(data.body);
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(data.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchOrders(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
          scheme: Uri.parse(APIEndpoints.ORDERS).scheme,
          host: Uri.parse(APIEndpoints.ORDERS).host,
          path: Uri.parse(APIEndpoints.ORDERS).path,
          queryParameters: jsonMap);

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchSpecificOrder(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.SPECIFIC_ORDER).scheme,
        host: Uri.parse(APIEndpoints.SPECIFIC_ORDER).host,
        path:
            '${Uri.parse(APIEndpoints.SPECIFIC_ORDER).path}/${jsonMap['order_id']}',
        // queryParameters: jsonMap
      );

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchHomeData(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
          scheme: Uri.parse(APIEndpoints.HOME).scheme,
          host: Uri.parse(APIEndpoints.HOME).host,
          path: Uri.parse(APIEndpoints.HOME).path,
          queryParameters: jsonMap);

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallReviewPost(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.REVIEW_POST).scheme,
        host: Uri.parse(APIEndpoints.REVIEW_POST).host,
        path: Uri.parse(APIEndpoints.REVIEW_POST).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallValidateCoupon(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
          scheme: Uri.parse(APIEndpoints.VALIDATE_COUPON).scheme,
          host: Uri.parse(APIEndpoints.VALIDATE_COUPON).host,
          path: Uri.parse(APIEndpoints.VALIDATE_COUPON).path,
          queryParameters: jsonMap);

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallPackageTypes(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.PACKAGE_TYPES).scheme,
        host: Uri.parse(APIEndpoints.PACKAGE_TYPES).host,
        path: Uri.parse(APIEndpoints.PACKAGE_TYPES).path,
        // queryParameters: jsonMap
      );

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallFetchProfile(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
          scheme: Uri.parse(APIEndpoints.GET_PROFILE).scheme,
          host: Uri.parse(APIEndpoints.GET_PROFILE).host,
          path: Uri.parse(APIEndpoints.GET_PROFILE).path,
          queryParameters: jsonMap);

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallRegister(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.REGISTER).scheme,
        host: Uri.parse(APIEndpoints.REGISTER).host,
        path: Uri.parse(APIEndpoints.REGISTER).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiiCallForgetPassword(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.FORGET_PASSWORD).scheme,
        host: Uri.parse(APIEndpoints.FORGET_PASSWORD).host,
        path: Uri.parse(APIEndpoints.FORGET_PASSWORD).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiiCallTrackOrder(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
          scheme: Uri.parse(APIEndpoints.TRACK_ORDER).scheme,
          host: Uri.parse(APIEndpoints.TRACK_ORDER).host,
          path: Uri.parse(APIEndpoints.TRACK_ORDER).path,
          queryParameters: jsonMap);

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallNotifications(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.NOTIFICATIONS).scheme,
        host: Uri.parse(APIEndpoints.NOTIFICATIONS).host,
        path: Uri.parse(APIEndpoints.NOTIFICATIONS).path,
        // queryParameters: jsonMap
      );

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallRatingAllowed(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.RATINGALLOWED).scheme,
        host: Uri.parse(APIEndpoints.RATINGALLOWED).host,
        path: '${Uri.parse(APIEndpoints.RATINGALLOWED).path}/${jsonMap['id']}',
      );

      var response = await http.get(uri, headers: headers);

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallInitializePaystack(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.PAY_WITH_PAYSTACK).scheme,
        host: Uri.parse(APIEndpoints.PAY_WITH_PAYSTACK).host,
        path: Uri.parse(APIEndpoints.PAY_WITH_PAYSTACK).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  Future<BaseModel> apiCallCheckTransactionStatus(
      Map<String, dynamic> jsonMap, RxBool isLoading) async {
    HttpOverrides.global = CustomHttpOverrides(); // Bypass SSL verification
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.VERIFY_TRANSACTION_PAYSTACK).scheme,
        host: Uri.parse(APIEndpoints.VERIFY_TRANSACTION_PAYSTACK).host,
        path: Uri.parse(APIEndpoints.VERIFY_TRANSACTION_PAYSTACK).path,
        // queryParameters: jsonMap
      );

      var response = await http.post(uri,
          headers: headers,
          body: jsonEncode(jsonMap),
          encoding: Encoding.getByName("utf-8"));

      isLoading.value = false;
      logMessage('${response.statusCode} ${response.body}');
      if (response.statusCode == 200) {
        var responseMap = jsonDecode(response.body);
        return BaseModel.fromMap(responseMap);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }
}

class CustomHttpClient {
  static Future<http.Response> post(
      Uri uri, Map<String, String> headers, String body) async {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Bypass certificate validation

    var request = await httpClient.postUrl(uri);
    headers.forEach((key, value) {
      request.headers.add(key, value);
    });
    request.write(body);

    var httpClientResponse = await request.close();

    // Read the response body as a string
    final responseBody =
        await httpClientResponse.transform(utf8.decoder).join();

    // Return an http.Response object with the status code and body
    return http.Response(responseBody, httpClientResponse.statusCode);
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
