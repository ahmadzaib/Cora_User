import 'package:coraapp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class TrackRiderScreen extends StatelessWidget {
  TrackRiderScreen({Key? key}) : super(key: key);
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
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
                    appbarText: 'Track Rider',
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            width: Get.width,
            child: Image.asset(
              mapImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        verticalSpace(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estimated Time",
                  style: regularWhiteText13(lightGreyColor),
                ),
                Container(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "01",
                        style: boldWhiteText32(darkBlackColor),
                      ),
                      Text(
                        "hr",
                        style: regularWhiteText13(darkBlackColor),
                      ),
                      Text(
                        ":",
                        style: boldWhiteText32(darkBlackColor),
                      ),
                      Text(
                        "45",
                        style: boldWhiteText32(darkBlackColor),
                      ),
                      Text(
                        "min",
                        style: regularWhiteText13(darkBlackColor),
                      ),
                    ],
                  ),
                ),
                verticalSpace(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: darkGreyColor,
                  ),
                  // decoration:bixRectangularAppBarBoxDecorationWithRadiusElevation(16, 8,
                  // color: darkGreyColor,
                  // shadowColor: fieldColor2),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: whiteContainerColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Image.asset(
                          cartoonIcon,
                          fit: BoxFit.fill,
                          height: 56,
                          width: 56,
                        ),
                      ),
                      horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Ada Ugonna",
                            style: regularWhiteText16(Colors.black),
                          ),
                          verticalSpace(height: 4),
                          Row(
                            children: [
                              Image.asset(
                                starIcon,
                                height: 12,
                                width: 12,
                              ),
                              horizontalSpace(width: 4),
                              Text(
                                "4.5 (289 Deliveries)",
                                style: regularWhiteText12(lightGreyColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        alignment: Alignment.center,
                        decoration:
                            bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                8, 8,
                                color: whiteContainerColor,
                                shadowColor: Colors.black12),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Image.asset(
                          ic_callIcon,
                          color: Colors.green,
                          height: 18,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace(height: 16),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(NamedRoutes.routeDeliveryInfoScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: blueAppColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: CustomizedButton(
                      buttonHeight: 48,
                      buttonWidth: Get.width,
                      text: 'Delivery Info',
                      textStyle: regularWhiteText16(whiteContainerColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(height: 24),
      ],
    );
  }
}
