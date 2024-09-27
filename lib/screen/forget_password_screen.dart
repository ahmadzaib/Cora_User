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

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  var phNoController = TextEditingController();

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
                    appbarText: 'Forgot Password',
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
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              verticalSpace(height: 24),
              Container(
                height: 180,
                width: 220,
                child: Image.asset(ic_forgetIcon),
              ),
              verticalSpace(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: darkGreyColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(height: 16),
                    Text(
                      "Phone Number",
                      style: regularWhiteText16(Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    verticalSpace(height: 6),
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                          color: whiteContainerColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 8,
                              color: Colors.black12,
                            )
                          ]),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          horizontalSpace(width: 14),
                          Image.asset(
                            ic_callIcon,
                            height: 20,
                            width: 20,
                          ),
                          horizontalSpace(width: 8),
                          Container(
                            height: 20,
                            width: .5,
                            color: lightGreyColor.withOpacity(.8),
                          ),
                          horizontalSpace(width: 6),
                          Text(
                            "+234",
                            style: regularWhiteText14(darkBlackColor,
                                fontWeight: FontWeight.w600),
                          ),
                          horizontalSpace(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: phNoController,
                              cursorColor: Colors.black,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.number,
                              style: regularWhiteText14(darkBlackColor,
                                  fontWeight: FontWeight.w500),
                              maxLength: 10,
                              decoration: InputDecoration(
                                  counterText: "",
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15.0, 20.0, 15.0),
                                  // filled: true,
                                  // fillColor: Colors.green,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Input your phone number',
                                  hintStyle: regularWhiteText14(lightGreyColor),
                                  constraints: BoxConstraints()),
                            ),
                          )
                        ],
                      ),
                    ),
                    verticalSpace(height: 24),
                    GestureDetector(
                      onTap: () {
                        if (isNotEmpty(phNoController.text)) {
                          Get.toNamed(NamedRoutes.routeOTP, arguments: {
                            'phone': '+234${phNoController.text}'
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blueAppColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: CustomizedButton(
                          buttonHeight: 48,
                          buttonWidth: Get.width,
                          text: 'Send',
                          textStyle: regularWhiteText16(whiteContainerColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    verticalSpace(height: 16),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         "Phone Number",
              //         style: regularWhiteText16(Colors.black,
              //             fontWeight: FontWeight.w500),
              //       ),
              //       verticalSpace(height: 6),
              //       Container(
              //         height: 52,
              //         decoration: BoxDecoration(
              //             color: whiteContainerColor,
              //             borderRadius: BorderRadius.circular(12),
              //             boxShadow: [
              //               BoxShadow(
              //                 offset: Offset(0, 0),
              //                 blurRadius: 8,
              //                 color: Colors.black12,
              //               )
              //             ]),
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             horizontalSpace(width: 14),
              //             Image.asset(
              //               ic_callIcon,
              //               height: 20,
              //               width: 20,
              //             ),
              //             horizontalSpace(width: 8),
              //             Container(
              //               height: 20,
              //               width: .5,
              //               color: lightGreyColor.withOpacity(.8),
              //             ),
              //             horizontalSpace(width: 6),
              //             Text(
              //               "+234",
              //               style: regularWhiteText14(darkBlackColor,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //             horizontalSpace(width: 8),
              //             Expanded(
              //               child: TextFormField(
              //                 controller: phNoController,
              //                 cursorColor: Colors.black,
              //                 textAlignVertical: TextAlignVertical.center,
              //                 keyboardType: TextInputType.number,
              //                 style: regularWhiteText14(darkBlackColor,
              //                     fontWeight: FontWeight.w500),
              //                 maxLength: 10,
              //                 decoration: InputDecoration(
              //                     counterText: "",
              //                     isCollapsed: true,
              //                     isDense: true,
              //                     contentPadding:
              //                         EdgeInsets.fromLTRB(0, 15.0, 20.0, 15.0),
              //                     // filled: true,
              //                     // fillColor: Colors.green,
              //                     border: OutlineInputBorder(
              //                       borderRadius: BorderRadius.zero,
              //                       borderSide: BorderSide.none,
              //                     ),
              //                     hintText: 'Input your phone number',
              //                     hintStyle: regularWhiteText14(lightGreyColor),
              //                     constraints: BoxConstraints()),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //       verticalSpace(height: 24),
              //       GestureDetector(
              //         onTap: () {
              //           Get.toNamed(NamedRoutes.routeOTP,
              //               arguments: {'phone': '+234${phNoController.text}'});
              //         },
              //         child: Container(
              //           decoration: BoxDecoration(
              //               color: blueAppColor,
              //               borderRadius: BorderRadius.circular(16)),
              //           child: CustomizedButton(
              //             buttonHeight: 48,
              //             buttonWidth: Get.width,
              //             text: 'Send',
              //             textStyle: regularWhiteText16(whiteContainerColor,
              //                 fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //       ),
              //       verticalSpace(height: 16),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
