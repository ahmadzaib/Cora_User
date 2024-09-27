import 'package:clipboard/clipboard.dart';
import 'package:coraapp/controllers/uiControllers/MainScreenController.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/json_utils.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class GetFreeDeliveryScreen extends StatefulWidget {
  GetFreeDeliveryScreen({Key? key}) : super(key: key);

  @override
  State<GetFreeDeliveryScreen> createState() => _GetFreeDeliveryScreenState();
}

class _GetFreeDeliveryScreenState extends State<GetFreeDeliveryScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  bool isSelected = false;
  String textData = "";

  late MainScreenController mainScreenController;

  @override
  void initState() {
    super.initState();
    mainScreenController = Get.find<MainScreenController>();
    // textData = 'Here\'s your unique referral code:${mainScreenController.userModel.value.referralCode}';
    textData =
        "Hey :wave::skin-tone-5:, do you have deliveries to make tomorrow? :package:"
        "\nSave delivery cost and deliver to anywhere in Lagos for only ₦1,500 with Cora Delivery."
        "\nUse my code ${mainScreenController.userModel.value.referralCode} to book a delivery for tomorrow here: https://onelink.to/9zmx8c";
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
                    appbarText: 'Refer To Friend',
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
      width: Get.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(height: 24),
              Container(
                height: 163,
                child: Image.asset(
                  freeDelivery,
                  fit: BoxFit.fill,
                ),
              ),
              verticalSpace(height: 24),
              Text(
                "Get FREE delivery!",
                style: boldWhiteText20(darkBlackColor),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Refer your friend to use Cora with your code \nand they will get a delivery for just ₦500 \nwhile you get a free delivery",
                      style: TextStyle(color: lightGreyColor, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              verticalSpace(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration:
                    bixRectangularAppBarBoxDecorationWithRadiusElevation(16, 8,
                        color: darkGreyColor, shadowColor: fieldColor2),
                child: Column(
                  children: [
                    Container(
                      width: 230,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration:
                          bixRectangularAppBarBoxDecorationWithRadiusElevation(
                              16, 8,
                              color: whiteContainerColor,
                              shadowColor: fieldColor2),
                      child: GestureDetector(
                        onTap: () {
                          FlutterClipboard.copy(textData)
                              .then((value) => print('copied'));
                          showSnackBar("Text Copied", context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                '${mainScreenController.userModel.value.referralCode}',
                                style: boldWhiteText18(darkBlackColor)),
                            Image.asset(
                              ic_codeImage,
                              height: 24,
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(height: 16),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration:
                          bixRectangularAppBarBoxDecorationWithRadiusElevation(
                              16, 8,
                              color: whiteContainerColor,
                              shadowColor: fieldColor2),
                      child: Column(
                        children: [
                          Text(
                            "Send your code",
                            style: regularWhiteText16(darkBlackColor),
                          ),
                          verticalSpace(height: 12),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  List.generate(socialImages.length, (index) {
                                return GestureDetector(
                                  onTap: () async {
                                    if (isSelected == true) {
                                      if (index == 0) {
                                        bool status =
                                            await openLink('whatsapp://send');
                                        if (!status) {
                                          await openLink(
                                              'https://play.google.com/store/apps/details?id=com.whatsapp');
                                        }
                                      } else if (index == 1) {
                                        bool status =
                                            await openLink('facebook://send');
                                        if (!status) {
                                          await openLink(
                                              'https://play.google.com/store/apps/details?id=com.facebook.katana');
                                        }
                                      } else if (index == 2) {
                                        openLink(
                                            'https://play.google.com/store/apps/details?id=org.telegram.messenger');
                                      } else if (index == 3) {
                                        openLink(
                                            'https://play.google.com/store/apps/details?id=com.twitter.android');
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 69,
                                    width: 69,
                                    alignment: Alignment.center,
                                    decoration:
                                        bixRectangularAppBarBoxDecorationWithRadiusElevation(
                                            34.5, 8,
                                            color: whiteContainerColor,
                                            shadowColor: Colors.black12),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Image.asset(
                                      socialImages[index],
                                      color: backIconColor,
                                    ),
                                  ),
                                );
                              })),
                          verticalSpace(height: 18),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isSelected = !isSelected;
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: isSelected
                                          ? darkBlackColor
                                          : whiteContainerColor,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: isSelected
                                              ? darkBlackColor
                                              : lightGreyColor)),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 4),
                                  child: Icon(
                                    Icons.check,
                                    size: 14,
                                    color: isSelected
                                        ? whiteContainerColor
                                        : lightGreyColor,
                                  ),
                                ),
                              ),
                              horizontalSpace(),
                              Text(
                                "terms and condition apply",
                                style: regularWhiteText13(lightGreyColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(height: 24),
                    GestureDetector(
                      onTap: () {
                        logMessage('Share');
                        shareIntent(share: textData);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color:
                                isSelected ? blueAppColor : Color(0xffB0A9C3),
                            borderRadius: BorderRadius.circular(16)),
                        child: CustomizedButton(
                          buttonHeight: 48,
                          buttonWidth: Get.width,
                          text: 'Send Your Code',
                          textStyle: regularWhiteText16(
                              isSelected ? whiteContainerColor : Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
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
