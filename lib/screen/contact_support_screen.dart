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

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
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
                    appbarText: 'Contact Support',
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
                supportImage,
                fit: BoxFit.fill,
              ),
            ),
            verticalSpace(height: 24),
            Text(
              "How can we help you?",
              style: regularWhiteText20(darkBlackColor,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Our customer support team is always available \nto help you have a stress-free experience while \nusing the Cora App",
                    style: TextStyle(color: lightGreyColor, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            verticalSpace(height: 24),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      bool status = await openLink(
                          'whatsapp://send?phone=+2349070644844');
                      if (!status) {
                        await openLink(
                            'https://play.google.com/store/apps/details?id=com.whatsapp');
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration:
                          bixRectangularAppBarBoxDecorationWithRadiusElevation(
                              16, 8,
                              color: whiteContainerColor,
                              shadowColor: Colors.black12),
                      child: Column(
                        children: [
                          verticalSpace(height: 16),
                          Image.asset(
                            whatsappImage,
                            height: 46,
                            width: 46,
                            fit: BoxFit.cover,
                          ),
                          verticalSpace(height: 12),
                          Text(
                            "Chat on WhatsApp",
                            style: regularWhiteText15(darkBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          verticalSpace(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
                horizontalSpace(),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      openLink("mailto:usecorang@gmail.com");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration:
                          bixRectangularAppBarBoxDecorationWithRadiusElevation(
                              16, 8,
                              color: whiteContainerColor,
                              shadowColor: Colors.black12),
                      child: Column(
                        children: [
                          verticalSpace(height: 16),
                          Image.asset(
                            ic_mailIcon,
                            height: 46,
                            width: 46,
                          ),
                          verticalSpace(height: 12),
                          Text(
                            "Send an Email",
                            style: regularWhiteText15(darkBlackColor,
                                fontWeight: FontWeight.w500),
                          ),
                          verticalSpace(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
