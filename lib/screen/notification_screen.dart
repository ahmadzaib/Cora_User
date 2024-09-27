import 'package:coraapp/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  late APIController apiController;

  var notifications = <NotificationModel>[].obs;

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeNotificationScreen);
    fetchNotifications();
    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status!)) {
        if (baseModel.code == 'NOTIFICATIONS') {
          notifications.value = ((baseModel.data ?? []) as List)
              .map((item) => NotificationModel.fromMap(item ?? {}))
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
                    appbarText: 'Notifications',
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
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(height: 16),
                Expanded(
                  child: Obx(() {
                    return SingleChildScrollView(
                      child: notifications.isEmpty
                          ? Center(child: Text('No found notifcation'))
                          : Column(
                              children:
                                  List.generate(notifications.length, (index) {
                                var notification = notifications[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        NamedRoutes.routeOrderCompleteScreen,
                                        arguments: {
                                          'order_id': int.tryParse(
                                                  notification.orderId) ??
                                              0
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: darkGreyColor),
                                      child: Column(
                                        children: [
                                          verticalSpace(height: 20),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${notification.title}",
                                                    style: regularWhiteText16(
                                                        darkBlackColor,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${notification.body}",
                                                    style: regularWhiteText14(
                                                        darkBlackColor),
                                                  ),
                                                  verticalSpace(height: 4),
                                                  Text(
                                                    "${dayAndMonth(notification.createdAt)}",
                                                    style: regularWhiteText12(
                                                        lightGreyColor,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),
                                              Image.asset(
                                                ic_notificationImage1,
                                                height: 68,
                                                width: 68,
                                              ),
                                            ],
                                          ),
                                          verticalSpace(height: 12),
                                        ],
                                      ),
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
        GenericProgressBar(tag: NamedRoutes.routeNotificationScreen)
      ],
    );
  }

  void fetchNotifications() {
    apiController.webservice
        .apiCallNotifications({}, apiController.isLoading).then(
            (value) => apiController.baseModel.value = value);
  }
}
