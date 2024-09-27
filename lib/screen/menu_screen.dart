import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/uiControllers/MainScreenController.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/json_utils.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  late MainScreenController mainScreenController;

  @override
  void initState() {
    super.initState();
    mainScreenController = Get.find<MainScreenController>();
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
                    appbarText: "Menu",
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
    return SingleChildScrollView(
      child: Container(
        width: Get.width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(height: 24),
              Center(child: Obx(() {
                return CircularAvatar(
                    imagePath:
                        "${mainScreenController.userModel.value.profile_image}",
                    imageSize: 100);
              })),
              verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello",
                    style: regularWhiteText14(lightGreyColor),
                  ),
                  horizontalSpace(width: 4),
                  Image.asset(
                    handIcon,
                    height: 14,
                    width: 12,
                  ),
                ],
              ),
              verticalSpace(height: 2),
              Text(
                "${mainScreenController.userModel.value.name}",
                style: boldWhiteText19(darkBlackColor),
              ),
              verticalSpace(height: 32),
              Column(
                children: List.generate(profileList.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Get.toNamed(NamedRoutes.routeFundWalletScreen);
                      } else if (index == 1) {
                        Get.toNamed(NamedRoutes.routeRecentDeliveryScreen);
                      } else if (index == 2) {
                        Get.toNamed(NamedRoutes.routeGetFreeDeliveryScreen);
                      } else if (index == 3) {
                        Get.toNamed(NamedRoutes.routeEditProfileScreen);
                      } else if (index == 4) {
                        Get.toNamed(NamedRoutes.routeContactSupportScreen);
                      } else if (index == 5) {
                        logoutUser();
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 44,
                            width: 44,
                            alignment: Alignment.center,
                            decoration:
                                bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                    8, 4,
                                    color: whiteContainerColor,
                                    shadowColor: Colors.black12),
                            padding: EdgeInsets.symmetric(
                                horizontal: 9, vertical: 10),
                            child: Image.asset(
                              profileList[index]['image'],
                              color: (index == 5) ? Colors.red : null,
                            ),
                          ),
                          horizontalSpace(width: 12),
                          Text(
                            profileList[index]['text'],
                            style: regularWhiteText16(
                                (index == 5) ? Colors.red : Colors.black),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              verticalSpace(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
