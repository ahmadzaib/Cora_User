

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

class DeliveryInfoScreen extends StatelessWidget {
  DeliveryInfoScreen({Key? key}) : super(key: key);
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
                  child:MySecondAppBar(
                    appbarLogo: ic_backIcon,
                    appbarText: 'Delivery Info',
                    fontStyle: FontStyle.normal,

                    onPress: () {  },

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
      width: Get.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children:  [
              verticalSpace(height: 24),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage(mapImage,),fit: BoxFit.fill)
                ),

              ),
              verticalSpace(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: darkGreyColor,
                ),

                // decoration:bixRectangularAppBarBoxDecorationWithRadiusElevation(16, 0,
                //     color: darkGreyColor,
                //     shadowColor: fieldColor2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("#Cr295J",style: regularWhiteText16(darkBlackColor, fontWeight: FontWeight.w500),),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                          decoration: BoxDecoration(
                            color: darkBlackColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text("In transit",style:regularWhiteText10(whiteContainerColor),),
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
                                  darkBlackColor)),
                          TextSpan(
                            text: " James Sunday",
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
                    DeliveryInfoWidget(
                      title: 'Pick-Up',
                      detail: '2, Jacob Sonola Str, Ogba',
                      islinkLineRequired: true,
                    ),
                    verticalSpace(height: 8),
                    DeliveryInfoWidget(
                      title: 'Drop-Off',
                      detail: '4, Adesina Str, Aguda Ada Ugonna (08099856254)',
                      islinkLineRequired: false,
                    ),
                    verticalSpace(height: 16),
                  ],
                ),
              ),
              verticalSpace(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: darkGreyColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(height: 16),
                    DeliveryInfoWidget(
                      title: 'Package Type',
                      detail: 'Cosmetics',
                      islinkLineRequired: true,
                    ),
                    verticalSpace(height: 8),
                    DeliveryInfoWidget(
                      title: 'Payment Method',
                      detail: '123456789',
                      islinkLineRequired: false,
                      isPaymentMethod: true,
                      icon: ic_addCardImage,

                    ),
                    verticalSpace(height: 13),
                    MyDivider(
                      color: backIconColor.withOpacity(0.10),
                    ),
                    verticalSpace(height: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("TOTAL",style: boldWhiteText19(darkBlackColor),),
                        Text("₦500",style: boldWhiteText24(darkBlackColor),),
                      ],
                    ),
                    verticalSpace(height: 16),
                  ],
                ),
              ),
              verticalSpace(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

