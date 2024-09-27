import 'package:clipboard/clipboard.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../models/orders_model.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class RecentDeliveryScreen extends StatefulWidget {
  RecentDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<RecentDeliveryScreen> createState() => _RecentDeliveryScreenState();
}

class _RecentDeliveryScreenState extends State<RecentDeliveryScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  late APIController apiController;
  // OrdersModel ordersModel = OrdersModel.fromMap({});
  var ordersModel = <OrdersModel>[].obs;
  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeRecentDeliveryScreen);
    fetchRecentOrders();
    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status!)) {
        if (baseModel.code == 'ORDERS') {
          // ordersModel  = OrdersModel.fromMap(baseModel.data);
          ordersModel.value = (baseModel.data as List)
              .map((e) => OrdersModel.fromMap(e ?? {}))
              .toList();
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
                    appbarText: 'Recent Deliveries',
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                verticalSpace(),
                Expanded(
                  child: Obx(() {
                    return ordersModel.isEmpty
                        ? Center(child: Text('No recent deliveries found'))
                        : MyCustomScrollBar(
                            child: Column(
                              children:
                                  List.generate(ordersModel.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        NamedRoutes.routeOrderCompleteScreen,
                                        arguments: {
                                          'order_id':
                                              ordersModel.value[index].id
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              horizontal: 14, vertical: 14),
                                          child: Image.asset(
                                            ordersModel.value![index]
                                                        .paymentMethod ==
                                                    'wallet'
                                                ? walletIcon
                                                : ic_dollarImage,
                                          ),
                                        ),
                                        horizontalSpace(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${ordersModel[index].name}",
                                              style: regularWhiteText16(
                                                  darkBlackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            verticalSpace(height: 4),
                                            Text(
                                              "${dayAndMonth(ordersModel[index].createdAt)}",
                                              style: regularWhiteText12(
                                                  lightGreyColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            verticalSpace(height: 4),
                                            Row(
                                              children: [
                                                Text(
                                                  "${ordersModel[index].orderId}",
                                                  style: regularWhiteText14(
                                                      darkBlackColor),
                                                ),
                                                horizontalSpace(width: 8),
                                                GestureDetector(
                                                    onTap: () {
                                                      FlutterClipboard.copy(
                                                              "${ordersModel[index].orderId}")
                                                          .then((value) =>
                                                              print('copied'));
                                                      showSnackBar(
                                                          "Text Copied",
                                                          context);
                                                    },
                                                    child: Image.asset(
                                                      ic_codeImage,
                                                      height: 14,
                                                      width: 14,
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/ic_naira_symbol.png',
                                              height: 16,
                                            ),
                                            Text(
                                              "${ordersModel[index].totalAmount}",
                                              style: regularWhiteText20(
                                                  darkBlackColor,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          );
                  }),
                ),
                verticalSpace(height: 16),
              ],
            ),
          ),
        ),
        Center(
          child: GenericProgressBar(
            tag: NamedRoutes.routeRecentDeliveryScreen,
          ),
        ),
      ],
    );
  }

  void fetchRecentOrders() {
    apiController.webservice
        .apiCallFetchOrders({}, apiController.isLoading).then(
            (value) => apiController.baseModel.value = value);
  }
}
