// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_maps_webservices/places.dart';

// import 'package:location/location.dart' as loc;
// import 'package:location/location.dart';

// import '../controllers/GoogleMapController/googlwmapcontroller.dart';
// import 'colors.dart';
// import 'decorations.dart';
// import 'images.dart';
// import 'utils.dart';
// import 'widgets.dart';

// class SearchPlacesScreen extends StatelessWidget {
//   final bool isSelectingFromLocation; // Add this parameter to differentiate

//   SearchPlacesScreen({Key? key, required this.isSelectingFromLocation})
//       : super(key: key);

//   final placesAPI =
//       GoogleMapsPlaces(apiKey: 'AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k');
//   final searchTextController = TextEditingController();

//   final RxList<Prediction> placesList = RxList<Prediction>();
//   final Rx<LatLng?> selectedPlaceLocation = Rx<LatLng?>(null);
//   final Rx<LatLng?> initialPosition = Rx<LatLng?>(null);

//   final mainController = Get.find<GoogleMapControl>();

//   Future<void> searchPlaces(String input) async {
//     if (input.isEmpty) {
//       placesList.clear();
//       return;
//     }
//     final response = await placesAPI.autocomplete(input);
//     if (response.isOkay) {
//       placesList.assignAll(response.predictions);
//     } else {
//       print('Error searching places: ${response.errorMessage}');
//       placesList.clear();
//     }
//   }

//   Future<LatLng?> getPlaceLocation(String placeId) async {
//     final response = await placesAPI.getDetailsByPlaceId(placeId);
//     if (response.isOkay) {
//       final location = response.result.geometry?.location;
//       final address = response.result.formattedAddress;
//       if (location != null) {
//         if (isSelectingFromLocation) {
//           // Update the "From Location" in the controller
//           mainController.fromLocation.value =
//               LatLng(location.lat, location.lng);
//           mainController.fromLocationAddress.value =
//               address ?? 'No address available';
//         } else {
//           // Update the "To Location" in the controller
//           mainController.toLocation.value = LatLng(location.lat, location.lng);
//           mainController.toLocationAddress.value =
//               address ?? 'No address available';
//         }
//         return LatLng(location.lat, location.lng);
//       }
//     }
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyScaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(90),
//         child: Container(
//           height: Get.height,
//           width: Get.width,
//           decoration: bizAppBarDecorationBox(),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               verticalSpace(height: 8),
//               SafeArea(
//                 child: MySecondAppBar(
//                   appbarLogo: ic_backIcon,
//                   appbarText: 'Search Places',
//                   fontStyle: FontStyle.normal,
//                   onPress: () {},
//                 ),
//               ),
//               verticalSpace(height: 12),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: whiteContainerColor,
//       body: getBody(),
//       resizeToAvoidBottomInset: true,
//     );
//   }

//   Stack getBody() {
//     return Stack(
//       children: [
//         Positioned(
//           top: 16.0,
//           left: 16.0,
//           right: 16.0,
//           child: TextField(
//             controller: searchTextController,
//             decoration: InputDecoration(
//               hintText: 'Search for a place',
//               prefixIcon: const Icon(Icons.search),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                   borderSide: BorderSide(color: Colors.grey)),
//             ),
//             onChanged: (value) => searchPlaces(value),
//           ),
//         ),
//         Positioned(
//           top: 80.0,
//           left: 16.0,
//           right: 16.0,
//           child: Obx(() {
//             if (placesList.isEmpty) {
//               return Container();
//             }
//             return Container(
//               color: Colors.white,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: placesList.length,
//                 itemBuilder: (context, index) {
//                   final place = placesList[index];
//                   return ListTile(
//                     leading: Icon(
//                       Icons.fmd_good_outlined,
//                       color: blueAppColor,
//                     ),
//                     title: Text(place.description ?? ''),
//                     onTap: () async {
//                       final location = await getPlaceLocation(place.placeId!);
//                       if (location != null) {
//                         selectedPlaceLocation.value = location;
//                         Get.back();
//                       }
//                     },
//                   );
//                 },
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }
