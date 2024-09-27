import 'dart:math';

import 'package:coraapp/controllers/apiControllers/api_controller.dart';
import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/orders_model.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

enum OrderStatusType { image, text }

class TrackOrderScreen extends StatefulWidget {
  TrackOrderScreen({Key? key}) : super(key: key);

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  late APIController apiController;
  var orderModel = OrdersModel.fromMap({}).obs;

  var _orderController = TextEditingController();

  String orderID = '';

  String uniqueControllerTag = '';

  var orderStatusesMaps = <Map<String, dynamic>>[
    {'id': 1, 'status': 'Pending', 'date': '', 'time': '', 'selected': false},
    {
      'id': 2,
      'status': 'Assigned to Rider',
      'date': '',
      'time': '',
      'selected': false
    },
    {
      'id': 3,
      'status': 'Package Picked',
      'date': '',
      'time': '',
      'selected': false
    },
    {
      'id': 4,
      'status': 'Package Delivered',
      'date': '',
      'time': '',
      'selected': false
    }
  ].obs;

  @override
  void initState() {
    super.initState();
    uniqueControllerTag = Random().nextInt(1024).toString();

    apiController = Get.put(APIController(), tag: uniqueControllerTag);

    orderID = ((Get.arguments ?? {})['order_id'] ?? "");
    onTapSearch(orderID);

    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status ?? true)) {
        if (baseModel.code == 'ORDER') {
          var order = OrdersModel.fromMap(baseModel.data);
          if (isNotEmpty(orderID)) {
            orderModel.value = order;
          } else {
            Get.toNamed(NamedRoutes.routeOrderCompleteScreen,
                arguments: {'order_id': order.id});
          }
        }
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
                  child: MySecondAppBar(
                    appbarLogo: ic_backIcon,
                    appbarText: 'Track Order',
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
                Visibility(
                  visible: isEmpty(orderID),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: darkGreyColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Enter Order ID to track your delivery",
                              style: regularWhiteText16(Colors.black),
                            )),
                          ],
                        ),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: CutomizedSearchTextField(
                                controller: _orderController,
                                enable: true,
                                onChangedValue: (e) {},
                                keyboard: TextInputType.text,
                                passwordVisible: false,
                                saveData: ((data) {}),
                                hintStyle: TextStyle(
                                    color: darkGreyColorTextField,
                                    fontSize: 12,
                                    decorationThickness: 0),
                                hintText: 'Please enter order id here',
                                prefixImage: ic_box,
                                prefixImageWidth: 16.0,
                                prefixImageHeight: 16.0,
                                padding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8, right: 6),
                              ),
                            ),
                            horizontalSpace(),
                            GestureDetector(
                              onTap: () {
                                onTapSearch(_orderController.text);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: blueAppColor,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14),
                                child: Image.asset(
                                  ic_search,
                                  height: 16,
                                  width: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(height: 24),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: orderModel.value.id == 0,
                        child: Container(
                          child: Image.asset(ic_trackImage),
                        ),
                      ),
                      Visibility(
                        visible: !(orderModel.value.id == 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${orderModel.value.orderId}",
                                    style: regularWhiteText16(darkBlackColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Visibility(
                                    visible: isNotEmpty(
                                        orderModel.value.orderStatus),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: lightgreenColor,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: Text(
                                        orderStatuses(
                                            type: OrderStatusType.text),
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
                                        style: regularWhiteText13(
                                            darkBlackColor,
                                            fontWeight: FontWeight.w400)),
                                    TextSpan(
                                      text:
                                          " ${isEmpty(orderModel.value.rider?.name) ? 'Not Assigned' : orderModel.value.rider?.name}",
                                      style: regularWhiteText13(
                                        lightGreyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace(height: 14),
                              MyDivider(
                                color: backIconColor.withOpacity(0.10),
                              ),
                              verticalSpace(height: 16),
                              buildOrderStatus(),
                              verticalSpace(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        GenericProgressBar(tag: uniqueControllerTag)
      ],
    );
  }

  Widget buildOrderStatus() {
    orderStatuses(type: OrderStatusType.image);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        orderStatusesMaps.length,
        (index) {
          var status = orderStatusesMaps[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    (status['selected'] as bool)
                        ? 'assets/images/ic_filled_order_status.png'
                        : 'assets/images/ic_unfilled_order_status.png',
                    height: 16,
                  ),
                  verticalSpace(height: 5),
                  (index == 3)
                      ? SizedBox()
                      : Container(
                          decoration: appSeparationLineDecoration,
                          width: 2,
                          height: 56,
                        ),
                  verticalSpace(height: 5),
                ],
              ),
              horizontalSpace(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${status['status']}',
                      style: boldWhiteText12(Colors.black),
                    ),
                    verticalSpace(height: 5),
                    Row(
                      children: [
                        Text(
                          '${status['date']}',
                          style: regularWhiteText10(darkGreyColorTextField),
                        ),
                        Spacer(),
                        Text(
                          '${status['time']}',
                          style: regularWhiteText10(darkGreyColorTextField),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  String orderStatuses({type = OrderStatusType.image}) {
    if (type == OrderStatusType.image) {
      if (orderModel.value.orderStatus == 'completed') {
        for (var element in orderStatusesMaps) {
          element['selected'] = true;
          if (element['id'] == 1) {
            element['date'] = dayAndMonth(orderModel.value.createdAt);
            element['time'] = hourAndMinute(orderModel.value.createdAt);
          } else if (element['id'] == 2) {
            element['date'] = '';
            element['time'] = '';
          } else if (element['id'] == 3) {
            element['date'] = dayAndMonth(orderModel.value.picked_at);
            element['time'] = hourAndMinute(orderModel.value.picked_at);
          } else if (element['id'] == 4) {
            element['date'] = dayAndMonth(orderModel.value.drop_at);
            element['time'] = hourAndMinute(orderModel.value.drop_at);
          }
        }

        return "";
      } else if (orderModel.value.orderStatus == 'pending') {
        for (var element in orderStatusesMaps) {
          if (element['id'] == 1) {
            element['date'] = dayAndMonth(orderModel.value.createdAt);
            element['time'] = hourAndMinute(orderModel.value.createdAt);
            element['selected'] = true;
          } else if (element['id'] == 2) {
            element['date'] = '';
            element['time'] = '';
          } else if (element['id'] == 3) {
            element['date'] = '';
            element['time'] = '';
          } else if (element['id'] == 4) {
            element['date'] = '';
            element['time'] = '';
          }
        }
        return "";
      } else if (orderModel.value.orderStatus == 'accepted') {
        for (var element in orderStatusesMaps) {
          if (element['id'] == 1) {
            element['date'] = dayAndMonth(orderModel.value.createdAt);
            element['time'] = hourAndMinute(orderModel.value.createdAt);
            element['selected'] = true;
          } else if (element['id'] == 2) {
            element['date'] = '';
            element['time'] = '';
            element['selected'] = true;
          } else if (element['id'] == 3) {
            element['date'] = dayAndMonth(orderModel.value.picked_at);
            element['time'] = hourAndMinute(orderModel.value.picked_at);
            element['selected'] = true;
          } else if (element['id'] == 4) {
            element['date'] = '';
            element['time'] = '';
          }
        }
        return "";
      } else if (orderModel.value.orderStatus == 'assigned') {
        for (var element in orderStatusesMaps) {
          if (element['id'] == 1) {
            element['date'] = dayAndMonth(orderModel.value.createdAt);
            element['time'] = hourAndMinute(orderModel.value.createdAt);
            element['selected'] = true;
          } else if (element['id'] == 2) {
            element['date'] = '';
            element['time'] = '';
            element['selected'] = true;
          } else if (element['id'] == 3) {
            element['date'] = '';
            element['time'] = '';
          } else if (element['id'] == 4) {
            element['date'] = '';
            element['time'] = '';
          }
        }
        return "";
      } else if (orderModel.value.orderStatus == 'cancelled') {
        return 'assets/images/ic_order_status_cancelled.png';
      } else {
        return '';
      }
    } else {
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
  }

  void onTapSearch(orderID) {
    if (isNotEmpty(orderID)) {
      apiController.webservice.apiiCallTrackOrder({
        'order_id': orderID
      }, apiController.isLoading).then(
          (value) => apiController.baseModel.value = value);
    }
  }
}
