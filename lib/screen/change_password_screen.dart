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

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();

  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _confirmasswordController = TextEditingController();

  bool eyeIconVisible = true;
  bool eyeIconVisible2 = true;

  late APIController apiController;

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeChangePassword);

    apiController.baseModel.listen((baseModel) {
      if (baseModel.code == 'FORGOTTEN_PASSWORD') {
        showSnackBar(baseModel.message!, context);
        Get.offAllNamed(NamedRoutes.routeLoginScreen);
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
                    appbarText: 'Change Password',
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
                child: Image.asset(ic_changePassword),
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
                      "Password",
                      style: regularWhiteText16(Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    verticalSpace(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            child: OnBoardingTextFieldWidget(
                              controller: _newpasswordController,
                              keyboard: TextInputType.text,
                              passwordVisible: eyeIconVisible,
                              hintText: ' Input your new password',
                              image: ic_lockIcon,
                              suffixxIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    eyeIconVisible = !eyeIconVisible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: eyeIconVisible
                                      ? Image.asset(
                                          hiddenPassword,
                                          scale: 4,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 22,
                                          color: lightGreyColor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(height: 20),
                    Text(
                      "Confirm Password",
                      style: regularWhiteText16(Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    verticalSpace(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: Get.width,
                            child: OnBoardingTextFieldWidget(
                              controller: _confirmasswordController,
                              keyboard: TextInputType.text,
                              passwordVisible: eyeIconVisible2,
                              hintText: ' Input your new password again',
                              image: ic_lockIcon,
                              suffixxIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    eyeIconVisible2 = !eyeIconVisible2;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: eyeIconVisible2
                                      ? Image.asset(
                                          hiddenPassword,
                                          scale: 4,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 22,
                                          color: lightGreyColor,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (validateFields()) {
                          onTapChangePassword();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: blueAppColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: CustomizedButton(
                          buttonHeight: 48,
                          buttonWidth: Get.width,
                          text: 'Change',
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
    );
  }

  void onTapChangePassword() {
    apiController.webservice.apiiCallForgetPassword({
      'phone': Get.arguments['phone'],
      'password': _newpasswordController.text,
    }, apiController.isLoading).then(
        (value) => apiController.baseModel.value = value);
  }

  bool validateFields() {
    if (isEmpty(_newpasswordController.text)) {
      showSnackBar('Please fill password', context);
    } else if (isEmpty(_confirmasswordController.text)) {
      showSnackBar('Please fill confirm password', context);
    } else if (_newpasswordController.text != _confirmasswordController.text) {
      showSnackBar('Passwords don\'t match', context);
    } else if (_newpasswordController.text.length < 8) {
      showSnackBar('Password must be 8 characters long', context);
    } else {
      return true;
    }

    return false;
  }
}
