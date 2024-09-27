import 'package:coraapp/models/orders_model.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../service_locator.dart';
import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class OrderCompleteScreen extends StatefulWidget {
  OrderCompleteScreen({Key? key}) : super(key: key);

  @override
  State<OrderCompleteScreen> createState() => _OrderCompleteScreenState();
}

class _OrderCompleteScreenState extends State<OrderCompleteScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  TextEditingController reviewController = TextEditingController();
  late APIController apiController;
  var orderModel = OrdersModel.fromMap({}).obs;
  int? orderId = 0;
  double? rating = 0;

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeOrderCompleteScreen);
    orderId = Get.arguments["order_id"];
    fetchGetOrder(orderId);
    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status!)) {
        if (baseModel.code == 'ORDER') {
          var order = OrdersModel.fromMap(baseModel.data);
          // ratingAllowed(order.riderId);
          orderModel.value = order;
        } else if (baseModel.code == 'ADD_REVIEW') {
          showSnackBar(baseModel.message!, context);
          Get.offAllNamed(NamedRoutes.routeHomeScreen);
        } else if (baseModel.code == 'ALLOW_REVIEW') {}
      }
    });
  }

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
                  child: Obx(() {
                    return MySecondAppBar(
                      appbarLogo: ic_backIcon,
                      appbarText: 'Order ${orderStatuses()}',
                      fontStyle: FontStyle.normal,
                      onPress: () {},
                    );
                  }),
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

  String orderStatuses() {
    if (orderModel.value.orderStatus == 'completed') {
      return 'Complete';
    } else if (orderModel.value.orderStatus == 'pending') {
      return 'Pending';
    } else if (orderModel.value.orderStatus == 'accepted') {
      return 'In-Progress';
    } else if (orderModel.value.orderStatus == 'assigned') {
      return 'Assigned to rider';
    } else if (orderModel.value.orderStatus == 'cancelled') {
      return 'Cancelled';
    } else {
      return '';
    }
  }

  getBody(Size size, BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            width: Get.width,
            child: Obx(() {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    verticalSpace(height: 24),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(NamedRoutes.routeTrackOrderScreen,
                            arguments: {
                              'order_id': orderModel.value.orderId,
                            });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: darkGreyColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${orderModel.value.orderId}",
                                  style: regularWhiteText16(darkBlackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                Visibility(
                                  visible:
                                      isNotEmpty(orderModel.value.orderStatus),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: lightgreenColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Text(
                                      "${orderStatuses()}",
                                      style: regularWhiteText10(
                                          whiteContainerColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(height: 4),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: ("Rider:"),
                                      style: regularWhiteText13(darkBlackColor,
                                          fontWeight: FontWeight.w400)),
                                  TextSpan(
                                    text:
                                        " ${isNotEmpty(orderModel.value.rider?.name) ? orderModel.value.rider?.name : 'Not Assigned'}",
                                    style: regularWhiteText13(
                                      lightGreyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // verticalSpace(height: 4),
                            // RichText(
                            //   textAlign: TextAlign.center,
                            //   text: TextSpan(
                            //     children: [
                            //       TextSpan(
                            //           text: ("phone:"),
                            //           style: regularWhiteText13(
                            //               darkBlackColor,fontWeight: FontWeight.w400)),
                            //       TextSpan(
                            //         text: " ${orderModel.value.rider?.phone}",
                            //         style: regularWhiteText13(
                            //           lightGreyColor,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            verticalSpace(height: 14),
                            MyDivider(
                              color: backIconColor.withOpacity(0.10),
                            ),
                            verticalSpace(height: 16),
                            DeliveryInfoWidget(
                              title: 'Pick-Up',
                              detail: '${orderModel.value.pickupAddress}',
                              islinkLineRequired: true,
                            ),
                            verticalSpace(height: 8),
                            DeliveryInfoWidget(
                              title: 'Drop-Off',
                              detail: '${orderModel.value.dropAddress}',
                              islinkLineRequired: false,
                            ),
                            verticalSpace(height: 16),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(height: 24),
                    Visibility(
                      visible: orderModel.value.orderStatus == 'completed',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircularAvatar(
                            imagePath: orderModel.value.rider?.profileImage,
                            imageSize: 12,
                            imageWidth: 100,
                            imageHeight: 100,
                          ),
                          verticalSpace(height: 14),
                          Text(
                            "${orderModel.value.rider?.name}",
                            style: regularWhiteText20(darkBlackColor,
                                fontWeight: FontWeight.w600),
                          ),
                          verticalSpace(height: 16),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            tapOnlyMode: false,
                            ignoreGestures: false,
                            itemCount: 5,
                            itemSize: 28,
                            itemPadding: EdgeInsets.symmetric(
                                horizontal: 2.0, vertical: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star_rounded,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rat) {
                              rating = rat;
                            },
                          ),
                          verticalSpace(height: 28),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: darkGreyColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Review",
                                  style: regularWhiteText16(darkBlackColor,
                                      fontWeight: FontWeight.w500),
                                ),
                                verticalSpace(height: 6),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 60,
                                        width: Get.width,
                                        child: CutomizedSearchTextField2(
                                          descriptionController:
                                              reviewController,
                                          enable: true,
                                          maxlines: 2,
                                          onChangedValue: (e) {},
                                          keyboard: TextInputType.text,
                                          passwordVisible: false,
                                          saveData: ((data) {}),
                                          hintStyle: TextStyle(
                                              color: darkGreyColorTextField,
                                              fontSize: 14,
                                              decorationThickness: 0,
                                              fontWeight: FontWeight.w400),
                                          hintText: 'Leave a review.',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          verticalSpace(height: 24),
                          GestureDetector(
                            onTap: () {
                              postYourReview();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blueAppColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: CustomizedButton(
                                buttonHeight: 48,
                                buttonWidth: Get.width,
                                text: 'Rate Rider',
                                textStyle:
                                    regularWhiteText16(whiteContainerColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(height: 24),
                  ],
                ),
              );
            }),
          ),
        ),
        GenericProgressBar(
          tag: NamedRoutes.routeOrderCompleteScreen,
        ),
      ],
    );
  }

  void fetchGetOrder(orderId) {
    apiController.webservice.apiCallFetchSpecificOrder({
      "order_id": orderId,
    }, apiController.isLoading).then(
        (value) => apiController.baseModel.value = value);
  }

  void ratingAllowed(riderId) {
    apiController.webservice.apiCallRatingAllowed({
      "id": riderId,
    }, apiController.isLoading).then(
        (value) => apiController.baseModel.value = value);
  }

  void postYourReview() {
    apiController.webservice.apiCallReviewPost({
      "rating": rating.toString(),
      "review": reviewController.text,
      "rider_id": orderModel.value.riderId,
    }, apiController.isLoading).then(
        (value) => apiController.baseModel.value = value);
  }
}
