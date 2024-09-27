import 'dart:convert';

import 'package:get/get.dart';

import '../models/baseModel/base_model.dart';
import '../utils/app_preferences.dart';
import '../utils/constants.dart';
import '../utils/handlers.dart';
import '../utils/utils.dart';
import 'package:http/http.dart' as http;

class MapService {
  static final MapService _singleton = MapService._internal();

  factory MapService() {
    return _singleton;
  }

  MapService._internal();

  //home api
  Future<BaseModel> apiCallPlaceSuggestions(Map<String, dynamic> jsonMap, RxBool isLoading) async {
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      // Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.PLACE_SUGGESTION).scheme,
        host: Uri.parse(APIEndpoints.PLACE_SUGGESTION).host,
        path: Uri.parse(APIEndpoints.PLACE_SUGGESTION).path,
        queryParameters: jsonMap
      );

      var response = await http.get(uri);
      isLoading.value = false;
      if (response.statusCode == 200) {
        List<String> suggestions = [];
        var body = jsonDecode(response.body);
        body['headers'] = response.headers;
        body['code'] = 'PLACE_SUGGESTION_RESULT';
        body['status'] =true;
        for (var e in (body['predictions'] as List)) {
          if(e['description'] is String){
            suggestions.add(e['description']);
          }
        }
        body['data'] = suggestions;
        return BaseModel.fromMap(body);
      } else {
        Handlers().apiResponseHandler(response);
        return BaseModel.fromMap(null);
      }
    } else {
      Handlers().apiResponseHandler(null, hasConnectivity: false);
      return BaseModel.fromMap(null);
    }
  }

  //home api
  Future<BaseModel> apiCallCoordinatesToAddress(Map<String, dynamic> jsonMap, RxBool isLoading) async {
    if (await appHasInternetConnectivity()) {
      isLoading.value = true;

      // Map<String, String> headers = appHeaders();

      var uri = Uri(
        scheme: Uri.parse(APIEndpoints.REVERSE_GEOCODING).scheme,
        host: Uri.parse(APIEndpoints.REVERSE_GEOCODING).host,
        path: Uri.parse(APIEndpoints.REVERSE_GEOCODING).path,
        queryParameters: jsonMap
      );

      var response = await http.get(uri);
      isLoading.value = false;
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        body['headers'] = response.headers;
        body['code'] = 'COORDINATES_ADDRESS';
        body['status'] =true;
        body['data'] = (body['results'] as List)[0]['formatted_address'];
        return BaseModel.fromMap(body);
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
