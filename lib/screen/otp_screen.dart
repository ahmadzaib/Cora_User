import 'package:coraapp/controllers/apiControllers/api_controller.dart';
import 'package:coraapp/services/firebase_service.dart';
import 'package:coraapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  late APIController apiController;

  var verifyID = '';

  @override
  void initState() {
    super.initState();
    apiController = Get.put(APIController(), tag: NamedRoutes.routeOTP);
    sendOTP();
  }

  void sendOTP() {
    apiController.firebaseService.serviceVerifyPhoneNumber(
        phoneNumber: Get.arguments['phone'],
        verificationCompleted: (credential) {},
        verificationFailed: (exc) => showSnackBar(exc.code, context),
        codeSent: (String verificationId, int? resendToken) {
          verifyID = verificationId;
          logMessage(
              'VerificationId-->${verificationId}\n resendToken-->${resendToken}');
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
                    appbarText: 'O.T.P',
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
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  verticalSpace(height: 24),
                  Container(
                    height: 180,
                    width: 220,
                    child: Image.asset(ic_otpIcon),
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
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "O.T.P",
                              style: regularWhiteText16(Colors.black,
                                  fontWeight: FontWeight.w500),
                            )),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Pinput(
                                length: 6,
                                keyboardType: TextInputType.number,
                                defaultPinTheme: PinTheme(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 14)),
                                pinAnimationType: PinAnimationType.slide,
                                forceErrorState: true,
                                closeKeyboardWhenCompleted: true,
                                onCompleted: (String? pin) {
                                  var credential = PhoneAuthProvider.credential(
                                      verificationId: verifyID, smsCode: pin!);
                                  apiController.firebaseService
                                      .loginUser(credential)
                                      .then((value) {
                                    if (isNotEmpty(value.user)) {
                                      Get.toNamed(
                                          NamedRoutes.routeChangePassword,
                                          arguments: Get.arguments);
                                    }
                                  });
                                },
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                onChanged: (value) {},
                                validator: (val) {
                                  if (val!.length < 6) {
                                    return "Please enter the OTP code";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(height: 6),
                        Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                                onTap: () {
                                  sendOTP();
                                },
                                child: Text(
                                  "Resend OTP?",
                                  style: regularWhiteText16(
                                      Color(
                                        0xffE94D2B,
                                      ),
                                      fontWeight: FontWeight.w400),
                                ))),
                        verticalSpace(height: 20),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                color: blueAppColor,
                                borderRadius: BorderRadius.circular(16)),
                            child: CustomizedButton(
                              buttonHeight: 48,
                              buttonWidth: Get.width,
                              text: 'Verify',
                              textStyle: regularWhiteText16(whiteContainerColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        verticalSpace(height: 16),
                      ],
                    ),
                  ),
                  verticalSpace(height: 16),
                ],
              ),
            ),
          ),
          const GenericProgressBar(tag: NamedRoutes.routeOTP)
        ],
      ),
    );
  }
}
