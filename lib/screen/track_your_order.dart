import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class TrackYourOderScreen extends StatefulWidget {
  TrackYourOderScreen({Key? key}) : super(key: key);

  @override
  State<TrackYourOderScreen> createState() => _TrackYourOderScreenState();
}

class _TrackYourOderScreenState extends State<TrackYourOderScreen> {
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
                    appbarText: 'Track order',
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
    return Container(
      height: Get.height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(),
              Text(
                "Pickup & Drop-off Address :",
                style: regularWhiteText16(darkBlackColor,
                    fontWeight: FontWeight.w500),
              ),
              verticalSpace(height: 16),
              DeliveryInfoWidget(
                title: 'Pick-Up',
                detail: 'National Stadium complex, yaba 102931',
                islinkLineRequired: true,
              ),
              verticalSpace(height: 8),
              DeliveryInfoWidget(
                title: 'Drop-Off',
                detail: 'Maryland Cres, Maryland 104858, Lagos',
                islinkLineRequired: false,
              ),
              verticalSpace(height: 8),
              MyDivider(),
              verticalSpace(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  children: [
                    OrderDetailWidget(
                      sizeOfLine: true,
                      visibleLine: true,
                      title: "Ordered",
                      color: blueAppColor,
                      disc: true,
                    ),
                    OrderDetailWidget(
                      title: "Accepted",
                      visibleLine: true,
                      color: lightGreyColor,
                      disc: false,
                    ),
                    OrderDetailWidget(
                      visibleLine: true,
                      title: "Arrived",
                      color: lightGreyColor,
                      disc: false,
                    ),
                    OrderDetailWidget(
                      visibleLine: true,
                      title: "Started",
                      color: lightGreyColor,
                      disc: false,
                    ),
                    OrderDetailWidget(
                      visibleLine: false,
                      title: "Delivered",
                      color: lightGreyColor,
                      disc: false,
                    ),
                  ],
                ),
              ),
              verticalSpace(height: 16),
              MyDivider(),
              verticalSpace(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bill Details",
                      style: regularWhiteText16(darkBlackColor,
                          fontWeight: FontWeight.w500),
                    ),
                    verticalSpace(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ride Fare",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₦1500.0",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Access Fee",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₦0.0",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(height: 10),
              MyDivider(),
              verticalSpace(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Coupon Savings",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₦0.0",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rounded Off",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₦0.0",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(height: 10),
              MyDivider(),
              verticalSpace(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Bill",
                          style: regularWhiteText16(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₦1500.0",
                          style: regularWhiteText13(darkBlackColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(height: 10),
              MyDivider(),
              verticalSpace(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "Payment Method",
                  style: regularWhiteText16(darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "Cod",
                  style: regularWhiteText13(darkBlackColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              verticalSpace(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
