import 'dart:async';

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
      _phNumber = TextEditingController(),
      _packageType = TextEditingController(),
      _senderName = TextEditingController(),
      _senderPhoneNumber = TextEditingController(),
      _senderAddress = TextEditingController(),
      _additionalInformation = TextEditingController();

  late APIController apiController;

  Map<String, double> pickupMap = {};
  Map<String, double> dropOffMap = {};
  Map<String, double> placemarks = {};

  var book = 'Calculate Fare'.obs;

  var totalAmount = '0'.obs;

  var couponController = TextEditingController();

  int discountAmount = 0;

  List<Map> packageTypes = [];

  String selectedPackageType = '';

  var deliveryType = 'same';

  var paymentMethod = 'wallet';

  @override
  void initState() {
    super.initState();

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
  }

  final DropdownController dropdownController = DropdownController();
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
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                                    child: TypeAheadField<String>(
                                      suggestionsCallback: (pattern) async {
                                        if (isNotEmpty(pattern)) {
                                          var basemodel = (await apiController
                                              .mapService
                                              .apiCallPlaceSuggestions({
                                            'input': pattern,
                                            'key': AppSecureInformation
                                                .MAPS_API_KEY
                                          }, apiController.isLoading));
                                          logMessage(basemodel);
                                          return (basemodel.data
                                              as List<String>);
                                        }
                                        return Future.value(['']);
                                      },
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'City',
                                          ),
                                        );
                                      },
                                      itemBuilder:
                                          (context, String suggestion) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Text(
                                            suggestion,
                                            style: regularWhiteText13(
                                                Colors.black),
                                          ),
                                        );
                                      },
                                      onSelected: (String suggestion) async {
                                        _dropOff.text = suggestion;
                                        List<Location> locations =
                                            await locationFromAddress(
                                                suggestion);
                                        if (isNotEmpty(locations) &&
                                            locations.isNotEmpty) {
                                          dropOffMap = {
                                            'drop_latitude':
                                                locations[0].latitude,
                                            'drop_longitude':
                                                locations[0].longitude,
                                          };
                                          book.value = 'Calculate Fare';
                                        }
                                      },
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await pickCurrentLocation();
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
                              hintStyle: TextStyle(
                                  color: darkGreyColorTextField,
                                  fontSize: 12,
                                  decorationThickness: 0,
                                  fontWeight: FontWeight.w400),
                              hintText: " Sender's Full Name",
                              prefixImage: ic_profileIcon,
                              suffixImage: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "",
                                ),
                              ),
                              padding: EdgeInsets.only(
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
                                    child: TypeAheadField<String>(
                                      suggestionsCallback: (pattern) async {
                                        if (isNotEmpty(pattern)) {
                                          var basemodel = (await apiController
                                              .mapService
                                              .apiCallPlaceSuggestions({
                                            'input': pattern,
                                            'key': AppSecureInformation
                                                .MAPS_API_KEY
                                          }, apiController.isLoading));
                                          logMessage(basemodel);
                                          return (basemodel.data
                                              as List<String>);
                                        }
                                        return Future.value(['']);
                                      },
                                      builder:
                                          (context, controller, focusNode) {
                                        return TextField(
                                          controller: controller,
                                          focusNode: focusNode,
                                          autofocus: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'City',
                                          ),
                                        );
                                      },
                                      itemBuilder:
                                          (context, String suggestion) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Text(
                                            suggestion,
                                            style: regularWhiteText13(
                                                Colors.black),
                                          ),
                                        );
                                      },
                                      onSelected: (String suggestion) async {
                                        _dropOff.text = suggestion;
                                        List<Location> locations =
                                            await locationFromAddress(
                                                suggestion);
                                        if (isNotEmpty(locations) &&
                                            locations.isNotEmpty) {
                                          dropOffMap = {
                                            'drop_latitude':
                                                locations[0].latitude,
                                            'drop_longitude':
                                                locations[0].longitude,
                                          };
                                          book.value = 'Calculate Fare';
                                        }
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
                              hintStyle: TextStyle(
                                  color: darkGreyColorTextField,
                                  fontSize: 12,
                                  decorationThickness: 0,
                                  fontWeight: FontWeight.w400),
                              hintText: ' Receiver’s Name',
                              prefixImage: ic_profileIcon,
                              suffixImage: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  "",
                                ),
                              ),
                              padding: EdgeInsets.only(
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
                          Container(
                            child: CoolDropdown(
                              controller:
                                  dropdownController, // Required controller
                              dropdownList: packageTypes.map((package) {
                                return CoolDropdownItem(
                                  label: package[
                                      'label'], // Adjust based on your data structure
                                  value: package['value'],
                                );
                              }).toList(),
                              onChange: (item) {
                                selectedPackageType =
                                    (item as CoolDropdownItem).label;
                                book.value = 'Calculate Fare';
                              },
                              resultOptions: ResultOptions(
                                width: size.width - 68,
                                height: 50,
                                padding: EdgeInsets.only(
                                    left: 46, top: 10, bottom: 10, right: 14),
                                textStyle: regularWhiteText13(Colors.black,
                                    fontWeight: FontWeight.w500),
                                placeholder: 'Choose',
                                // placeholder: regularWhiteText13(darkGreyColorTextField),
                                icon: Image.asset(
                                  ic_arrowDownIcon,
                                  scale: 4,
                                ),
                                // iconRotation: false,
                              ),
                              dropdownOptions: DropdownOptions(
                                width: 200,
                                height: 190,
                              ),
                              dropdownItemOptions: DropdownItemOptions(
                                height: 30,
                                alignment: Alignment.center,
                                selectedTextStyle: regularWhiteText15(
                                    Colors.black,
                                    fontWeight: FontWeight.w500),
                                selectedBoxDecoration: const BoxDecoration(
                                  color: blueAppColor,
                                ),
                              ),
                              isMarquee: false,
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
                          Container(
                            child: CoolDropdown(
                              controller:
                                  dropdownController, // Required controller
                              dropdownList: packageTypes.map((package) {
                                return CoolDropdownItem(
                                  label: package[
                                      'label'], // Adjust based on your data structure
                                  value: package['value'],
                                );
                              }).toList(),
                              onChange: (item) {
                                selectedPackageType =
                                    (item as CoolDropdownItem).label;
                                book.value = 'Calculate Fare';
                              },
                              resultOptions: ResultOptions(
                                width: size.width - 68,
                                height: 50,
                                padding: EdgeInsets.only(
                                    left: 46, top: 10, bottom: 10, right: 14),
                                // textStyle: regularWhiteText13(Colors.black,
                                //     fontWeight: FontWeight.w500),

                                // placeholder:
                                //     regularWhiteText13(darkGreyColorTextField),
                                icon: Image.asset(
                                  ic_arrowDownIcon,
                                  scale: 4,
                                ),
                                // iconRotation: false,
                              ),
                              dropdownOptions: DropdownOptions(
                                width: 200,
                                height: 190,
                              ),
                              dropdownItemOptions: DropdownItemOptions(
                                height: 30,
                                alignment: Alignment.center,
                                // selectedTextStyle: regularWhiteText15(
                                //     Colors.black,
                                //     fontWeight: FontWeight.w500),
                                selectedBoxDecoration: const BoxDecoration(
                                  color: blueAppColor,
                                ),
                              ),
                              isMarquee: false,
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
                                  hintStyle: TextStyle(
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
                                      margin: EdgeInsets.symmetric(
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
                                  padding: EdgeInsets.only(
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
                              margin: EdgeInsets.only(bottom: 16),
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
                                    padding: EdgeInsets.symmetric(
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
                                      padding: EdgeInsets.symmetric(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
        'pickup_address': _pickupAddress.text,
        'drop_address': _dropOff.text,
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
    if (isEmpty(_pickupAddress.text)) {
      showSnackBar('Please fill pickup address', context);
    } else if (isEmpty(_dropOff.text)) {
      showSnackBar('Please fill drop off address', context);
    } else if (pickupMap.isEmpty) {
      showSnackBar('Please choose your pickup address', context);
    } else if (dropOffMap.isEmpty) {
      showSnackBar('Please choose your drop off address', context);
    } else if (isEmpty(_deliverTo.text)) {
      showSnackBar('Please fill recipient name', context);
    } else if (isEmpty(_phNumber.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(selectedPackageType)) {
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
