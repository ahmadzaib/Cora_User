import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PlacesController extends GetxController {
  var placeList = [].obs; // Observable list for places
  String currentAddress = ''; // To store current address
  // Function to get suggestions
  void getSuggestions(String input) async {
    const String PLACES_API_KEY = "AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$PLACES_API_KEY';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        placeList.value = data['predictions']; // Update the observable list
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to get address from coordinates
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    const String PLACES_API_KEY = "AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k";
    String baseURL = 'https://maps.googleapis.com/maps/api/geocode/json';
    String request = '$baseURL?latlng=$latitude,$longitude&key=$PLACES_API_KEY';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['results'].isNotEmpty) {
        return data['results'][0]['formatted_address'];
      }
      return 'Address not found';
    } else {
      throw Exception('Failed to load address');
    }
  }
}

class mapcontroller extends GetxController {
  var placeList = [].obs; // Observable list for places

  // Function to get suggestions based on user input
  void getSuggestions(String input) async {
    const String PLACES_API_KEY = "AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request = '$baseURL?input=$input&key=$PLACES_API_KEY';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        placeList.value = data['predictions']; // Update the observable list
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }
}
