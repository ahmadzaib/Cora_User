import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coraapp/helper/Auth/auth_helper.dart';
import 'package:coraapp/models/Auth/login_model.dart';
import 'package:coraapp/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../service_locator.dart';
import '../services/fcm_service.dart';
import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  final AuthHelper _authHelper = getIt<AuthHelper>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool selectEyeIconVissible = true;
  late APIController apiController;

  Future<void> _loginWithGoogle() async {
    try {
      Map isGoogleLogin = await _authHelper.loginWithGoogle();
      isGoogleLogin["device_token"] = await FcmService.instance.getFCMToken();
      if (isGoogleLogin.isNotEmpty) {
        socialLogin(isGoogleLogin);
      } else {
        log('login with google failed');
        Get.snackbar('', 'Login with google failed');
      }
    } catch (e) {
      log('Error in login with google $e');
    }
  }

  Future<void> _loginWithApple() async {
    try {
      Map isGoogleLogin = await _authHelper.loginWithApple();
      isGoogleLogin["device_token"] = await FcmService.instance.getFCMToken();
      if (isGoogleLogin.isNotEmpty) {
        socialLogin(isGoogleLogin);
      } else {
        log('login with google failed');
        Get.snackbar('', 'Login with google failed');
      }
    } catch (e) {
      log('Error in login with google $e');
    }
  }

  void loginApi(userData) {
    if (validateFields()) {
      apiController.webservice
          .apiCallLogin(userData, apiController.isLoading)
          .then((value) {
        return apiController.baseModel.value = value;
      });
    }
  }

  void socialLogin(userData) {
    apiController.webservice
        .apiCallLogin(userData, apiController.isLoading)
        .then((value) {
      return apiController.baseModel.value = value;
    });
  }

  bool validateFields() {
    if (isEmpty(_phoneController.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(_passwordController.text)) {
      showSnackBar('Please fill password', context);
    } else {
      return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    apiController = Get.put(APIController(), tag: NamedRoutes.routeLoginScreen);
    apiController.baseModel.listen((baseModel) {
      if (baseModel.code == 'LOGIN') {
        log('baseModel.data ${baseModel.data}');
        LoginModel loginModel = LoginModel.fromMap(baseModel.data);
        Map loginModelMap = loginModel.toJson();
        globalPreferences?.setString(
            AppPreferences.ID_USER, "${loginModel.id}");
        globalPreferences?.setString(
            AppPreferences.TOKEN, "${loginModel.token}");
        globalPreferences?.setString(
            AppPreferences.USER_MODEL, jsonEncode(loginModelMap));
        Get.offNamed(NamedRoutes.routeHomeScreen);
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
                    isBackButtonRequired: false,
                    appbarText: 'Login',
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
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(height: 19),
                Text(
                  'Welcome Back',
                  style: regularWhiteText24(darkBlackColor,
                      fontWeight: FontWeight.w400),
                ),
                verticalSpace(height: 8),
                Image.asset(
                  onBoardingImage,
                  height: 220,
                ),
                verticalSpace(height: 24),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: darkGreyColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                offset: Offset(0, 8),
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
                                cursorColor: Colors.black,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.number,
                                controller: _phoneController,
                                style: regularWhiteText14(Colors.black,
                                    fontWeight: FontWeight.w500),
                                maxLength: 10,
                                decoration: InputDecoration(
                                  counterText: "",
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 15.0, 20.0, 15.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Input your phone number',
                                  hintStyle: regularWhiteText14(lightGreyColor),
                                  constraints: BoxConstraints(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpace(height: 20),
                      Text(
                        "Password",
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
                                offset: Offset(0, 8),
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
                              ic_lockIcon,
                              height: 20,
                              width: 20,
                            ),
                            horizontalSpace(width: 8),
                            Container(
                              height: 20,
                              width: .5,
                              color: lightGreyColor.withOpacity(.8),
                            ),
                            horizontalSpace(width: 8),
                            Expanded(
                              child: TextFormField(
                                cursorColor: Colors.black,
                                textAlignVertical: TextAlignVertical.center,
                                keyboardType: TextInputType.text,
                                obscureText: selectEyeIconVissible,
                                controller: _passwordController,
                                style: regularWhiteText14(Colors.black,
                                    fontWeight: FontWeight.w500),
                                maxLength: 40,
                                decoration: InputDecoration(
                                  counterText: "",
                                  isCollapsed: true,
                                  isDense: true,
                                  contentPadding:
                                      EdgeInsets.fromLTRB(0, 10.0, 20.0, 15.0),
                                  // filled: true,
                                  // fillColor: Colors.green,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide.none,
                                  ),
                                  hintText: 'Input your password',
                                  hintStyle: regularWhiteText14(lightGreyColor),
                                  constraints: BoxConstraints(),
                                ),
                              ),
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectEyeIconVissible =
                                        !selectEyeIconVissible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: selectEyeIconVissible
                                      ? Image.asset(
                                          hiddenPassword,
                                          height: 17,
                                          width: 18.5,
                                        )
                                      : Icon(
                                          Icons.remove_red_eye_outlined,
                                          size: 22,
                                          color: lightGreyColor,
                                        ),
                                )),
                            horizontalSpace(width: 7.5),
                          ],
                        ),
                      ),
                      verticalSpace(height: 8),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(NamedRoutes.routeForgetPasswordScreen);
                        },
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forget Password?",
                              style: regularWhiteText13(redColor,
                                  fontWeight: FontWeight.w400),
                            )),
                      ),
                      verticalSpace(height: 20),
                      GestureDetector(
                        onTap: () async {
                          loginApi({
                            "phone": '+234${_phoneController.text}',
                            "password": _passwordController.text,
                            "user_type": 'user',
                            "device_token":
                                await FcmService.instance.getFCMToken(),
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: blueAppColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: CustomizedButton(
                            buttonHeight: 48,
                            buttonWidth: Get.width,
                            text: 'Login',
                            textStyle: regularWhiteText16(whiteContainerColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      verticalSpace(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Haven’t any account?',
                            style: regularWhiteText13(darkGreyColorTextField,
                                fontWeight: FontWeight.w400),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(NamedRoutes.routeSignUpScreen);
                            },
                            child: Text(
                              ' Sign Up',
                              style: regularWhiteText13(blueAppColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 32),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Or Login With",
                            style: regularWhiteText13(Colors.black,
                                fontWeight: FontWeight.w500),
                          )),
                      verticalSpace(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (Platform.isAndroid) {
                                  _loginWithGoogle();
                                } else {
                                  _loginWithApple();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: whiteContainerColor,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 8),
                                          blurRadius: 8,
                                          color:
                                              Colors.black12.withOpacity(.07))
                                    ]),
                                child: CustomizedButton(
                                  buttonHeight: 48,
                                  imgb: (Platform.isIOS)
                                      ? ic_apple
                                      : ic_googleIcon,
                                  buttonWidth: Get.width,
                                  text: (Platform.isIOS) ? 'Apple' : 'Google',
                                  textStyle: regularWhiteText16(Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          horizontalSpace(),
                          Expanded(
                            child: (Platform.isAndroid)
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: whiteContainerColor,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 8),
                                              blurRadius: 8,
                                              color: Colors.black12
                                                  .withOpacity(.07))
                                        ]),
                                    child: CustomizedButton(
                                      buttonHeight: 48,
                                      imgb: ic_facebookIcon,
                                      buttonWidth: Get.width,
                                      text: 'Facebook',
                                      textStyle: regularWhiteText16(
                                          Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSpace(height: 20),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GenericProgressBar(
              tag: NamedRoutes.routeLoginScreen,
            ),
          ],
        ),
      ],
    );
  }
}
