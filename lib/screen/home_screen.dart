import 'package:clipboard/clipboard.dart';
import 'package:coraapp/controllers/apiControllers/api_controller.dart';
import 'package:coraapp/models/Auth/login_model.dart';
import 'package:coraapp/models/home_model.dart';

import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:fbroadcast/fbroadcast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../controllers/uiControllers/MainScreenController.dart';
import '../models/orders_model.dart';
import '../service_locator.dart';
import '../services/fcm_service.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  late APIController apiController;
  var homeModel = HomeModel.fromMap({}).obs;
  late MainScreenController mainScreenController;

  // OrdersModel ordersModel = OrdersModel.fromMap({});
  var ordersModel = <OrdersModel>[].obs;
  final _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    apiController = Get.put(APIController(), tag: NamedRoutes.routeHomeScreen);
    mainScreenController = Get.put(MainScreenController());
    FcmService.instance.retrieveAnyPendingNotificationsPayload();
    FcmService.instance.bindForgroundMessageListener({});
    fetchUserProfile();
    fetchHomeData();
    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status ?? true)) {
        if (baseModel.code == 'Home') {
          homeModel.value = HomeModel.fromMap(baseModel.data);
        } else if (baseModel.code == 'PROFILE') {
          mainScreenController.userModel.value =
              LoginModel.fromMap(baseModel.data);
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
                    isNewScreenRequired: true,
                    appbarLogo: menuIcon,
                    appbarRightLogo: ic_notificationIcon,
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
      children: [
        Container(
          height: Get.height,
          child: Obx(() {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: PullDownToRefresh(
                onRefresh: () {
                  _refreshController.refreshCompleted();
                  fetchHomeData();
                },
                controller: _refreshController,
                child: Column(
                  children: [
                    verticalSpace(height: 24),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(NamedRoutes.routeFundWalletScreen);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 21),
                        width: 280,
                        decoration:
                            userImageRectangularAppBarBoxDecorationWithRadiusElevation(
                                16, backGroundImage, 8,
                                color: whiteContainerColor,
                                shadowColor: Colors.black12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Your Balance",
                              style: regularWhiteText14(lightGreyColor),
                            ),
                            verticalSpace(height: 8),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/images/ic_naira_symbol.png',
                                  height: 24,
                                ),
                                Text(
                                  "${homeModel.value.wallet}",
                                  style: boldWhiteText28(Colors.black),
                                ),
                              ],
                            ),
                            verticalSpace(height: 8),
                            Container(
                              width: 104,
                              decoration: BoxDecoration(
                                  color: blueAppColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: CustomizedButton(
                                buttonHeight: 26,
                                text: 'Fund Wallet',
                                textStyle:
                                    regularWhiteText12(whiteContainerColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Deliveries",
                          style: regularWhiteText20(Colors.black),
                        ),
                        GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  NamedRoutes.routeRecentDeliveryScreen);
                            },
                            child: Text(
                              "See All",
                              style: regularWhiteText14(blueAppColor,
                                  fontWeight: FontWeight.w400),
                            )),
                      ],
                    ),
                    verticalSpace(height: 12),
                    Expanded(
                      child: MyCustomScrollBar(
                        child: Column(
                          children: List.generate(
                              homeModel.value.orders!.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    NamedRoutes.routeOrderCompleteScreen,
                                    arguments: {
                                      'order_id':
                                          homeModel.value.orders![index].id
                                    });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: darkGreyColor),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 56,
                                      width: 56,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: whiteContainerColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 11),
                                      child: Image.asset(
                                        homeModel.value.orders![index]
                                                    .paymentMethod ==
                                                'wallet'
                                            ? walletIcon
                                            : ic_dollarImage,
                                      ),
                                    ),
                                    horizontalSpace(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${homeModel.value.orders?[index].name}",
                                          style: regularWhiteText16(
                                              Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        verticalSpace(height: 4),
                                        Text(
                                          "${dayAndMonth(homeModel.value.orders?[index].createdAt)}",
                                          style: regularWhiteText12(
                                              lightGreyColor),
                                        ),
                                        verticalSpace(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "${homeModel.value.orders?[index].orderId}",
                                              style: regularWhiteText14(
                                                  darkBlackColor),
                                            ),
                                            horizontalSpace(width: 8),
                                            GestureDetector(
                                              onTap: () {
                                                FlutterClipboard.copy(
                                                        "${homeModel.value.orders?[index].orderId}")
                                                    .then((value) =>
                                                        print('copied'));
                                                showSnackBar(
                                                    "Text Copied", context);
                                              },
                                              child: Image.asset(
                                                ic_codeImage,
                                                height: 14,
                                                width: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Row(
                                      children: [
                                        buildPriceWidget(index),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(NamedRoutes.routeTrackOrderScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: darkBlackColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: CustomizedButton(
                                buttonHeight: 48,
                                text: 'Track Order',
                                textStyle:
                                    regularWhiteText16(whiteContainerColor),
                              ),
                            ),
                          ),
                        ),
                        horizontalSpace(),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                  NamedRoutes.routeDelievryDetailScreen);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: blueAppColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: CustomizedButton(
                                buttonHeight: 48,
                                text: 'Book Rider',
                                textStyle:
                                    regularWhiteText16(whiteContainerColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(height: 14),
                  ],
                ),
              ),
            );
          }),
        ),
        Center(
          child: GenericProgressBar(
            tag: NamedRoutes.routeHomeScreen,
          ),
        ),
      ],
    );
  }

  Widget buildPriceWidget(int index) {
    var amount = 0.0;
    if ((double.tryParse(homeModel.value.orders?[index].discountedAmount) ??
            0) >
        0) {
      amount =
          (double.tryParse(homeModel.value.orders?[index].discountedAmount) ??
              0);
    } else {
      amount =
          (double.tryParse(homeModel.value.orders?[index].totalAmount) ?? 0);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/ic_naira_symbol.png',
          height: 16,
        ),
        Text(
          "${amount}",
          style: regularWhiteText18(Colors.black),
        ),
      ],
    );
  }

  void fetchHomeData() {
    apiController.webservice
        .apiCallFetchHomeData({}, apiController.isLoading).then(
            (value) => apiController.baseModel.value = value);
  }

  void fetchOrders() {
    apiController.webservice
        .apiCallFetchOrders({}, apiController.isLoading).then(
            (value) => apiController.baseModel.value = value);
  }

  void fetchUserProfile() {
    apiController.webservice.apiCallFetchProfile({}, RxBool(false)).then(
        (value) => apiController.baseModel.value = value);
  }
}
