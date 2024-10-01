import 'dart:async';
import 'dart:convert';

import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:coraapp/controllers/apiControllers/api_controller.dart';
import 'package:coraapp/controllers/applicationControllers/application_controller.dart';
import 'package:coraapp/controllers/uiControllers/MainScreenController.dart';
import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/json_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:get/get_connect/http/src/utils/utils.dart';
import '../controllers/GoogleMapController/googlwmapcontroller.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/permission_utils.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class DeliveryDetailScreen extends StatefulWidget {
  const DeliveryDetailScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailScreen> createState() => _DeliveryDetailScreenState();
}

class _DeliveryDetailScreenState extends State<DeliveryDetailScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  late MainScreenController mainScreenController;

  var selectedItemGender = 'Male';
  String? selectedValue;

  var selected = 0;

  var _pickupAddress = TextEditingController(),
      _dropOff = TextEditingController(),
      _deliverTo = TextEditingController(),
      _delivery_off = TextEditingController(),
      _phNumber = TextEditingController(),
      _packageType = TextEditingController(),
      _senderName = TextEditingController(),
      _senderPhoneNumber = TextEditingController(),
      _senderAddress = TextEditingController(),
      _additionalInformation = TextEditingController();

  late APIController apiController;

  Map<String, double> pickupMap = {};
  Map<String, double> dropOffMap = {
    'drop_latitude': 0.0343,
    'drop_longitude': 0.342424
  };
  Map<String, double> placemarks = {};

  var book = 'Calculate Fare'.obs;
  var totalAmount = '0'.obs;
  var couponController = TextEditingController();
  int discountAmount = 0;
  List<Map> packageTypes = [];
  String selectedPackageType = '';
  var deliveryType = 'same';
  var paymentMethod = 'wallet';
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    // TODO: implement dispose
    _dropOff.dispose();
    _controller.dispose();
    _focusNode.dispose();
    fromaddresscontroller.dispose();
    _fromfocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _dropOff = TextEditingController();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeDelievryDetailScreen);
    mainScreenController = Get.find<MainScreenController>();
    senderDetail();
    Get.find<ApplicationController>().packageTypes.forEach((element) {
      packageTypes.add({
        'label': element.categoryName,
        'value': element.categoryName,
        'categoryIcon': element.categoryIcon,
        'id': element.id
      });
    });

    apiController.baseModel.listen((baseModel) {
      if (baseModel.status!) {
        if (baseModel.code == 'DISTANCE_CALCULATE') {
          book.value = 'Book Rider';
          totalAmount.value = baseModel.data['total'].toString();
        } else if (baseModel.code == 'PLACE_ORDER') {
          Get.offAllNamed(NamedRoutes.routeHomeScreen);
        } else if (baseModel.code == 'VALIDATE_COUPON') {
          discountAmount =
              int.tryParse(baseModel.data['discount'].toString()) ?? 0;
          var discountedPrice =
              ((double.tryParse(totalAmount.value) ?? 0) - discountAmount);
          if (discountedPrice < 1) {
            discountedPrice = 0;
          }
          totalAmount.value = discountedPrice.toString();
        }
      }
    });

    _getCurrentLocation(); // Get the current location when the app starts
    _controller.addListener(() {
      if (_focusNode.hasFocus) {
        if (_controller.text.isNotEmpty) {
          _placesController.getSuggestions(_controller.text);
          _isSuggestionVisible = true; // Show suggestions
        } else {
          _isSuggestionVisible = false; // Hide suggestions if no text
        }
      } else {
        _isSuggestionVisible = false; // Hide suggestions when not focused
      }
      setState(() {}); // Refresh the UI
    });
    // Add focus listener to handle focus changes
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _isSuggestionVisible = false; // Hide suggestions when focus is lost
        setState(() {}); // Refresh the UI
      }
    });
    // Listen for changes in focus
    _fromfocusNode.addListener(() {
      setState(() {
        // Show suggestions when focused, hide when not focused
        _fromisSuggestionVisible = _fromfocusNode.hasFocus;
      });
    });

    fromaddresscontroller.addListener(() {
      // Trigger suggestions only when focused
      if (_fromfocusNode.hasFocus) {
        if (fromaddresscontroller.text.isNotEmpty) {
          controllers.getSuggestions(fromaddresscontroller.text);
        } else {
          controllers.placeList.clear(); // Clear suggestions if input is empty
        }
      }
    });
  }

  final TextEditingController _controller = TextEditingController();
  final PlacesController _placesController = Get.put(PlacesController());
  final controllers = Get.put(mapcontroller());

  bool _isSuggestionVisible = false; // Track visibility of suggestions
  String _currentAddress = '';

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle it accordingly
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when permission is denied
        return Future.error('Location permissions are denied.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String address = await _placesController.getAddressFromCoordinates(
        position.latitude, position.longitude);
    pickupMap = {
      'pickup_latitude': position.latitude,
      'pickup_longitude': position.longitude,
    };

    setState(() {
      _currentAddress = address; // Store the current address
      _controller.text = _currentAddress!; // Display it in the TextField
    });
  }

  final TextEditingController fromaddresscontroller = TextEditingController();

  final FocusNode _fromfocusNode = FocusNode();
  bool _fromisSuggestionVisible = false;
  String fromLocationAddress = 'dsfsdfsdf'; // To store selected address
  double fromLocationLatitude = 0.023412; // To store selected latitude
  double fromLocationLongitude = 0.123123; // To store selected longitude
  // Function to get details from place ID
  Future<void> getPlaceDetails(String placeId) async {
    const String PLACES_API_KEY = "AIzaSyCa-bvn_Yn-y9qBLglmPPSQ4HJRecxgd8k";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$baseURL?place_id=$placeId&key=$PLACES_API_KEY';

    try {
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('Response Data: $data'); // Log the entire response data

        if (data['result'] != null) {
          // Set selected address and its coordinates
          fromLocationAddress = data['result']['formatted_address'];
          fromLocationLatitude = data['result']['geometry']['location']['lat'];
          fromLocationLongitude = data['result']['geometry']['location']['lng'];
        } else {
          print('No result found for placeId: $placeId');
        }
      } else {
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load place details: $e');
    }
  }

  final DropdownController selectedTypeController = DropdownController();
  final DropdownController deliveryTypeController = DropdownController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        _customFormHelper.checkfocus(context, currentFocus);
      },
      child: MyScaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            height: Get.height,
            width: Get.width,
            decoration: bizAppBarDecorationBox(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                verticalSpace(height: 8),
                SafeArea(
                  child: MySecondAppBar(
                    appbarLogo: ic_backIcon,
                    appbarText: 'Delivery Details',
                    fontStyle: FontStyle.normal,
                    onPress: () {},
                  ),
                ),
                verticalSpace(height: 12),
              ],
            ),
          ),
        ),
        backgroundColor: whiteContainerColor,
        body: getBody(size, context),
        resizeToAvoidBottomInset: true,
      ),
    );
  }

  getBody(Size size, BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: darkGreyColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pick-Up Address",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: Get.width,
                              decoration:
                                  bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                      12, 8,
                                      color: whiteContainerColor,
                                      shadowColor:
                                          Colors.black12.withOpacity(.06)),
                              child: Row(
                                children: [
                                  horizontalSpace(width: 10),
                                  Image.asset(
                                    ic_locationIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                  horizontalSpace(width: 6),
                                  Container(
                                    height: 20,
                                    width: .5,
                                    color: lightGreyColor.withOpacity(.8),
                                  ),
                                  horizontalSpace(width: 6),
                                  Expanded(
                                    child: TypeAheadField(
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                          focusNode: _focusNode,
                                          controller: _controller,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              decorationThickness: 0,
                                              fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            hintText: "choose pick_up point",
                                            focusColor: Colors.white,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (pattern) async {
                                        if (pattern.isNotEmpty) {
                                          _placesController
                                              .getSuggestions(pattern);

                                          return _placesController
                                              .placeList; // Return suggestions
                                        }
                                        return [];
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title:
                                              Text(suggestion['description']),
                                        );
                                      },
                                      onSelected: (suggestion) {
                                        FocusScope.of(context).unfocus();
                                        _controller.text = suggestion[
                                            'description']; // Set selected address
                                        _placesController.placeList
                                            .clear(); // Clear suggestions
                                        _isSuggestionVisible =
                                            false; // Hide suggestions
                                        setState(() {}); // Refresh the UI
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      _getCurrentLocation();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 24),
                                      child: Image.asset(
                                        ic_currentLocationIcon,
                                        height: 24,
                                        width: 24,
                                        color: backIconColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: _isSuggestionVisible
                                ? 200
                                : 0, // Fixed height for suggestions
                            child: Obx(() => Container(
                                  decoration:
                                      bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                          12, 8,
                                          color: whiteContainerColor,
                                          shadowColor:
                                              Colors.black12.withOpacity(.06)),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        _placesController.placeList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(_placesController
                                            .placeList[index]["description"]),
                                        onTap: () {
                                          _controller.text = _placesController
                                              .placeList[index]["description"];
                                          _placesController.placeList
                                              .clear(); // Clear suggestions
                                          _isSuggestionVisible =
                                              false; // Hide suggestions
                                          setState(() {}); // Refresh the UI
                                        },
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CutomizedSearchTextField(
                              controller: _senderName,
                              enable: true,
                              onChangedValue: (e) {},
                              keyboard: TextInputType.text,
                              passwordVisible: false,
                              saveData: ((data) {}),
                              hintStyle: const TextStyle(
                                  color: darkGreyColorTextField,
                                  fontSize: 12,
                                  decorationThickness: 0,
                                  fontWeight: FontWeight.w400),
                              hintText: " Sender's Full Name",
                              prefixImage: ic_profileIcon,
                              suffixImage: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "",
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10, top: 8, bottom: 8, right: 6),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OnBoardingTextFieldWidget1(
                              controller: _senderPhoneNumber,
                              // enable: true,
                              // onChangedValue: (e) {},
                              keyboard: TextInputType.number,
                              passwordVisible: false,
                              hintText: " Sender's Phone Number",
                              image: ic_callIcon,
                              // prefixImage: ic_callIcon,
                              // prefixImageWidth: 20.0,
                              // prefixImageHeight: 20.0,
                              // padding: EdgeInsets.only(
                              //     left: 10, top: 8, bottom: 8, right: 6),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Text(
                        "Drop-Off Address",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: Get.width,
                              decoration:
                                  bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                      12, 8,
                                      color: whiteContainerColor,
                                      shadowColor:
                                          Colors.black12.withOpacity(.06)),
                              child: Row(
                                children: [
                                  horizontalSpace(width: 10),
                                  Image.asset(
                                    ic_carIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                  horizontalSpace(width: 6),
                                  Container(
                                    height: 20,
                                    width: .5,
                                    color: lightGreyColor.withOpacity(.8),
                                  ),
                                  horizontalSpace(width: 6),
                                  Expanded(
                                    child: TypeAheadField(
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                          focusNode: _fromfocusNode,
                                          controller: fromaddresscontroller,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              decorationThickness: 0,
                                              fontWeight: FontWeight.w500),
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none),
                                            hintText: "chose drop_off point",
                                            hintStyle: TextStyle(
                                                color: darkGreyColorTextField,
                                                fontSize: 13,
                                                decorationThickness: 0,
                                                fontWeight: FontWeight.w500),
                                            focusColor: Colors.white,
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                          ),
                                        );
                                      },
                                      suggestionsCallback: (pattern) async {
                                        if (pattern.isNotEmpty) {
                                          controllers.getSuggestions(pattern);

                                          return controllers
                                              .placeList; // Return suggestions
                                        }
                                        return [];
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title:
                                              Text(suggestion['description']),
                                        );
                                      },
                                      onSelected: (suggestion) async {
                                        dropOffMap = {
                                          'drop_latitude': 0.0343,
                                          'drop_longitude': 0.342424
                                        };
                                        var placeId = suggestion['place_id'];
                                        // Fetch the details for the selected place
                                        getPlaceDetails(placeId);
                                        fromaddresscontroller.text = suggestion[
                                            'description']; // Set selected address
                                        controllers.placeList
                                            .clear(); // Clear suggestions
                                        _fromisSuggestionVisible =
                                            false; // Hide suggestions
                                        FocusScope.of(context).unfocus();
                                        setState(() {}); // Refresh the UI
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Stack(
                        children: [
                          Container(
                            height: _fromisSuggestionVisible
                                ? 200
                                : 0, // Fixed height for suggestions
                            child: Obx(() => Container(
                                  decoration:
                                      bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                          12, 8,
                                          color: whiteContainerColor,
                                          shadowColor:
                                              Colors.black12.withOpacity(.06)),
                                  child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controllers.placeList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(controllers.placeList[index]
                                            ["description"]),
                                        onTap: () {
                                          fromaddresscontroller.text =
                                              controllers.placeList[index]
                                                  ["description"];
                                          controllers.placeList
                                              .clear(); // Clear suggestions
                                          _fromisSuggestionVisible =
                                              false; // Hide suggestions
                                          setState(() {}); // Refresh the UI
                                        },
                                      );
                                    },
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Text(
                        "Deliver To",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: CutomizedSearchTextField(
                              controller: _deliverTo,
                              enable: true,
                              onChangedValue: (e) {},
                              keyboard: TextInputType.text,
                              passwordVisible: false,
                              saveData: ((data) {}),
                              hintStyle: const TextStyle(
                                  color: darkGreyColorTextField,
                                  fontSize: 12,
                                  decorationThickness: 0,
                                  fontWeight: FontWeight.w400),
                              hintText: ' Receiver’s Name',
                              prefixImage: ic_profileIcon,
                              suffixImage: GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  "",
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 10, top: 8, bottom: 8, right: 6),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Text(
                        "Phone Number",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: OnBoardingTextFieldWidget1(
                              controller: _phNumber,
                              // enable: true,
                              // onChangedValue: (e) {},
                              keyboard: TextInputType.number,
                              passwordVisible: false,
                              hintText: ' Receiver’s Number',
                              image: ic_callIcon,
                              // prefixImage: ic_callIcon,
                              // prefixImageWidth: 20.0,
                              // prefixImageHeight: 20.0,
                              // padding: EdgeInsets.only(
                              //     left: 10, top: 8, bottom: 8, right: 6),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Text(
                        "Package Type",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Stack(
                        children: [
                          WillPopScope(
                            onWillPop: () async {
                              if (selectedTypeController.isOpen) {
                                selectedTypeController.close();
                                return Future.value(false);
                              } else {
                                return Future.value(true);
                              }
                            },
                            child: Container(
                              child: CoolDropdown(
                                controller:
                                    selectedTypeController, // Required controller
                                dropdownList: packageTypes.map((package) {
                                  return CoolDropdownItem(
                                    label: package[
                                        'label'], // Adjust based on your data structure
                                    value: package['value'],
                                  );
                                }).toList(),
                                onChange: (item) async {
                                  setState(() {});
                                  selectedPackageType =
                                      (item as CoolDropdownItem).label;
                                  book.value = 'Calculate Fare';

                                  // Reset error state if there is any
                                  if (selectedTypeController.isError) {
                                    await selectedTypeController.resetError();
                                  }

                                  // Optionally close the dropdown after selection
                                  selectedTypeController.close();
                                },
                                resultOptions: ResultOptions(
                                  width: size.width - 68,
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                    left: 46,
                                    top: 10,
                                    bottom: 10,
                                    right: 14,
                                  ),
                                  textStyle: regularWhiteText13(Colors.black,
                                      fontWeight: FontWeight.w500),
                                  placeholder: 'Choose',
                                  icon: Image.asset(
                                    ic_arrowDownIcon,
                                    scale: 4,
                                  ),
                                ),
                                dropdownOptions: const DropdownOptions(
                                  width: 200,
                                  height: 190,
                                ),
                                dropdownItemOptions: DropdownItemOptions(
                                  height: 30,
                                  alignment: Alignment
                                      .center, // Center-align dropdown items
                                  isMarquee: true, // Enable marquee for items
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  render: DropdownItemRender.all,
                                  textStyle: TextStyle(fontSize: 13),
                                  selectedTextStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  selectedBoxDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        blueAppColor, // Background color for selected item
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            child: Row(
                              children: [
                                horizontalSpace(width: 10),
                                Image.asset(
                                  ic_box,
                                  height: 20,
                                  width: 20,
                                ),
                                horizontalSpace(width: 6),
                                Container(
                                  height: 20,
                                  width: .5,
                                  color: lightGreyColor.withOpacity(.8),
                                ),
                                horizontalSpace(width: 6),
                              ],
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 20),
                      Text(
                        "Delivery Type",
                        style: regularWhiteText16(Colors.black),
                      ),
                      verticalSpace(height: 6),
                      Stack(
                        children: [
                          WillPopScope(
                            onWillPop: () async {
                              if (deliveryTypeController.isOpen) {
                                deliveryTypeController.close();
                                return Future.value(false);
                              } else {
                                return Future.value(true);
                              }
                            },
                            child: CoolDropdown(
                              controller:
                                  deliveryTypeController, // Use the retained controller
                              isMarquee: false, // Disable marquee effect
                              dropdownList: List.generate(
                                items.length,
                                (index) {
                                  return CoolDropdownItem(
                                    label: items[
                                        index], // Assuming each item is a string
                                    value: items[index],
                                  );
                                },
                              ).toList(),

                              onChange: (item) async {
                                setState(() {});
                                deliveryType = (item as CoolDropdownItem).label;
                                book.value =
                                    'Calculate Fare'; // Update book value

                                // Logic for handling specific dropdown selection
                                if (item.value == packageTypes[1]['value']) {
                                  deliveryType = 'same'; // Set to 'same'
                                } else {
                                  deliveryType = 'other'; // Set to 'other'
                                }

                                // Reset error state if there is any
                                if (deliveryTypeController.isError) {
                                  await deliveryTypeController.resetError();
                                }

                                // Optionally close the dropdown after selection
                                deliveryTypeController.close();
                              },
                              resultOptions: ResultOptions(
                                width: size.width - 68,
                                height: 50,
                                padding: const EdgeInsets.only(
                                    left: 46, top: 10, bottom: 10, right: 14),
                                textStyle: regularWhiteText13(Colors.black,
                                    fontWeight: FontWeight.w500),
                                placeholder: 'Delivery Type',
                                icon: Image.asset(
                                  ic_arrowDownIcon,
                                  scale: 4,
                                ),
                              ),

                              dropdownOptions: const DropdownOptions(
                                width: 200,
                                height: 190,
                                gap: DropdownGap.all(5),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                align: DropdownAlign.left,
                                animationType: DropdownAnimationType.size,
                              ),

                              dropdownTriangleOptions:
                                  const DropdownTriangleOptions(
                                width: 20,
                                height: 30,
                                align: DropdownTriangleAlign.left,
                                borderRadius: 3,
                                left: 20,
                              ),

                              dropdownItemOptions: DropdownItemOptions(
                                height: 30,
                                alignment: Alignment
                                    .center, // Center-align dropdown items
                                isMarquee: true, // Enable marquee for items
                                mainAxisAlignment: MainAxisAlignment.start,
                                render: DropdownItemRender.all,
                                textStyle: TextStyle(fontSize: 13),
                                selectedTextStyle: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                selectedBoxDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:
                                      blueAppColor, // Background color for selected item
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 16,
                            child: Row(
                              children: [
                                horizontalSpace(width: 10),
                                Image.asset(
                                  ic_deliverytypeIcon,
                                  height: 20,
                                  width: 20,
                                ),
                                horizontalSpace(width: 6),
                                Container(
                                  height: 20,
                                  width: .5,
                                  color: lightGreyColor.withOpacity(.8),
                                ),
                                horizontalSpace(width: 6),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Visibility(
                    visible: !(book.value == 'Calculate Fare'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration:
                                    rectangularCustomColorBoxAndBorderDecorationWithRadius(
                                        12, Colors.white, lighterGreyColor,
                                        borderWidth: 0.6),
                                height: 48,
                                width: Get.width,
                                child: CutomizedSearchTextField(
                                  controller: couponController,
                                  enable: true,
                                  onChangedValue: (e) {},
                                  keyboard: TextInputType.text,
                                  passwordVisible: false,
                                  saveData: ((data) {}),
                                  hintStyle: const TextStyle(
                                      color: darkGreyColorTextField,
                                      fontSize: 12,
                                      decorationThickness: 0,
                                      fontWeight: FontWeight.w400),
                                  hintText: 'Enter Coupon Code',
                                  prefixImage: ic_couponcodeIcon,
                                  suffixImage: GestureDetector(
                                    onTap: () {
                                      onTapApplyCoupon();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 6),
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: blueAppColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Center(
                                          child: Text("Apply",
                                              style: regularWhiteText12(
                                                  Colors.white,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                    ),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8, right: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // verticalSpace(height: 24),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //         child: Padding(
                        //       padding: const EdgeInsets.only(left: 10),
                        //       child: CutomizedSearchTextField(
                        //         controller: couponController,
                        //         hintText: "Enter Coupon", passwordVisible: false, keyboard: null, saveData: (String? data) {  },
                        //       ),
                        //     )),
                        //     GestureDetector(
                        //       onTap: () {
                        //         onTapApplyCoupon();
                        //       },
                        //       child: Container(
                        //         padding: EdgeInsets.all(10),
                        //         decoration:
                        //             rectangularAppBarColorBoxDecorationWithRadius(
                        //                 0, 0, 10, 10, blueAppColor),
                        //         child: Center(
                        //           child: Text(
                        //             "Apply",
                        //             style: boldWhiteText14(Colors.white),
                        //           ),
                        //         ),
                        //       ),
                        //     )
                        //   ],
                        // ),
                        verticalSpace(height: 24),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pay With",
                              style: regularWhiteText20(Colors.black),
                            )),
                        verticalSpace(height: 12),
                        Column(
                          children: List.generate(paymentList.length, (index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    alignment: Alignment.center,
                                    decoration:
                                        bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                            8, 8,
                                            color: whiteContainerColor,
                                            shadowColor: Colors.black12),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 11),
                                    child: Image.asset(
                                      paymentList[index]['image'],
                                    ),
                                  ),
                                  horizontalSpace(),
                                  Text(
                                    paymentList[index]['text'],
                                    style: regularWhiteText16(Colors.black),
                                  ),
                                  Expanded(child: Container()),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selected = index;
                                        paymentMethod =
                                            paymentList[index]['key'];
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: (selected == index)
                                                  ? darkBlackColor
                                                  : lightGreyColor),
                                          color: selected == index
                                              ? darkBlackColor
                                              : whiteContainerColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: Icon(
                                        Icons.check_outlined,
                                        size: 14,
                                        color: (selected == index)
                                            ? whiteContainerColor
                                            : lightGreyColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        verticalSpace(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "TOTAL ",
                              style: regularWhiteText20(Colors.black),
                            ),
                            Obx(() {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/images/ic_naira_symbol.png',
                                    height: 24,
                                  ),
                                  Text(
                                    "${(double.tryParse(totalAmount.value) ?? 0.0).toPrecision(2)}",
                                    style: boldWhiteText24(Colors.black),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
                verticalSpace(height: 21),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.close(1);
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: darkBlackColor,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Image.asset(
                          ic_crossIcon,
                        ),
                      ),
                    ),
                    horizontalSpace(),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          onTapBookRider(book.value);
                        },
                        child: Obx(() {
                          return Container(
                            decoration: BoxDecoration(
                                color: blueAppColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: CustomizedButton(
                              buttonHeight: 48,
                              buttonWidth: Get.width,
                              text: book.value,
                              textStyle:
                                  regularWhiteText16(whiteContainerColor),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                verticalSpace(height: 20),
              ],
            ),
          ),
        ),
        GenericProgressBar(tag: NamedRoutes.routeDelievryDetailScreen)
      ],
    );
  }

  Future<void> pickCurrentLocation() async {
    if (await PermissionUtils.handleLocationPermission()) {
      userCurrentLocation();
    }
  }

  void onTapBookRider(String book) {
    if (validateFields()) {
      Map<String, dynamic> map = {
        'name': _deliverTo.text,
        'phone': '+234${_phNumber.text}',
        'package_type': selectedPackageType,
        'description': _additionalInformation.text,
        'pickup_address': _currentAddress,
        'drop_address': fromLocationAddress,
        'payment_method': paymentMethod,
        'sender_name': _senderName.text,
        'sender_phone': _senderPhoneNumber.text,
        'total_amount': totalAmount.value
      };

      if (discountAmount > 0) {
        // map['total_amount'] = ((double.tryParse(totalAmount.value)??0) + discountAmount).toString();
        map['total_amount'] =
            ((double.tryParse(totalAmount.value) ?? 0)).toString();
        map['discounted_price'] = totalAmount.value;
      }

      map.addAll(pickupMap);
      map.addAll(dropOffMap);

      if (book == 'Calculate Fare') {
        apiController.webservice
            .apiCallCalculateDistance(
                {'delivery_day': deliveryType}
                  ..addAll(pickupMap)
                  ..addAll(dropOffMap),
                apiController.isLoading)
            .then((value) => apiController.baseModel.value = value);
      } else {
        apiController.webservice
            .apiCallPlaceOrder(map, apiController.isLoading)
            .then((value) => apiController.baseModel.value = value);
      }
    }
  }

  bool validateFields() {
    if (isEmpty(_currentAddress)) {
      showSnackBar('Please fill pickup address', context);
    } else if (fromLocationAddress == '') {
      showSnackBar('Please fill drop off address', context);
    } else if (pickupMap.isEmpty) {
      showSnackBar('Please choose your pickup address', context);
    } else if (isEmpty(deliveryTypeController)) {
      showSnackBar('Please fill recipient name', context);
    } else if (isEmpty(_phNumber.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(selectedTypeController)) {
      showSnackBar('Please provide your package information', context);
    } else {
      return true;
    }

    return false;
  }

  Future<void> userCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double long = position.longitude;
    pickupMap = {
      'pickup_latitude': lat,
      'pickup_longitude': long,
    };

    var response = await apiController.mapService.apiCallCoordinatesToAddress(
        {'latlng': '$lat,$long', 'key': AppSecureInformation.MAPS_API_KEY},
        apiController.isLoading);

    _pickupAddress.text = response.data;
  }

  void onTapApplyCoupon() {
    if (isNotEmpty(couponController.text)) {
      if (discountAmount == 0) {
        apiController.webservice.apiCallValidateCoupon({
          'coupon_code': couponController.text
        }, apiController.isLoading).then(
            (value) => apiController.baseModel.value = value);
      }
    } else {
      showSnackBar('Please fill coupon code', context);
    }
  }

  void senderDetail() {
    pickCurrentLocation();
    _senderName.text = '${mainScreenController.userModel.value.name}';
    _senderPhoneNumber.text =
        '${mainScreenController.userModel.value.phone.toString().replaceAll('+234', '')}';
  }
}
