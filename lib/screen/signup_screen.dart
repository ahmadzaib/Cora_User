import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_shadow/simple_shadow.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../helper/FilePicker/file_picker_helper.dart';
import '../models/Auth/login_model.dart';
import '../service_locator.dart';
import '../services/fcm_service.dart';
import '../store/auth_store.dart';
import '../utils/app_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/custom_validator.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/function_response.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

enum ValidationChecker { name, phone, email, password, referral, unKnown }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  final AuthScreenStore _authScreenStore = getIt<AuthScreenStore>();
  final CustomValidator _customValidator = getIt<CustomValidator>();
  final FilePickerHelper _filePickerHelper = getIt<FilePickerHelper>();
  bool eyeIcon = true;

  final _signUpNameKey = GlobalKey<FormState>();
  final _signUpPhoneKey = GlobalKey<FormState>();
  final _signUpEmailKey = GlobalKey<FormState>();
  final _signUpPasswordKey = GlobalKey<FormState>();

  late APIController apiController;

  Future<void> _signUpUser() async {
    if(validateFields()){
      uploadImage(_authScreenStore.profileImage);
    }
  }

  bool validateFields() {
    if (isEmpty(_authScreenStore.profileImage)) {
      showSnackBar('Please upload picture', context);
    } else if (isEmpty(_authScreenStore.nameController.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(_authScreenStore.phoneNumberController.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(_authScreenStore.emailController.text)) {
      showSnackBar('Please fill email', context);
    } else if (!(getIt<CustomValidator>().validateEmailAddress(_authScreenStore.emailController.text))) {
      showSnackBar('Provided email is invalid', context);
    } else if (isEmpty(_authScreenStore.passwordController.text)) {
      showSnackBar('Please fill password', context);
    } else if (_authScreenStore.passwordController.text.length<8) {
      showSnackBar('Password must be 8 characters long', context);
    } else {
      return true;
    }

    return false;
  }

  void uploadImage(imagePath) {
    apiController.webservice
        .apiCallUploadImage(imagePath, apiController.isLoading)
        .then((value) {
      return apiController.baseModel.value = value;
    });
  }

  void registerApi(Map<String, dynamic> userData) {
    apiController.webservice
        .apiCallRegister(userData, apiController.isLoading)
        .then((value) {
      return apiController.baseModel.value = value;
    });
  }

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeSignUpScreen);
    apiController.baseModel.listen((baseModel) async{
      if (baseModel.code == 'UPLOAD_IMAGE') {
        final userProfileUrl = baseModel.data['profile_image'] ?? '';
        Map<String, dynamic> loginModelMap = {
          'name': _authScreenStore.nameController.text,
          'phone': '+234${_authScreenStore.phoneNumberController.text}',
          'email': _authScreenStore.emailController.text,
          'password': _authScreenStore.passwordController.text,
          'profile_image': userProfileUrl,
          "user_type": 'user',
          "referral_code": _authScreenStore.referralCodeController.text,
          "device_token": await FcmService.instance.getFCMToken(),
        };
        registerApi(loginModelMap);
      } else if (baseModel.code == 'REGISTRATION') {

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
                    appbarLogo: ic_backIcon,
                    appbarText: 'Sign Up',
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
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(height: 16),
                GestureDetector(
                  onTap: () async {
                    FunctionResponse _functionResponse = getIt<FunctionResponse>();
                    _functionResponse = await _filePickerHelper.pickImageFromGallery(ImageSource.gallery, context);
                    _functionResponse.printResponse();
                  },
                  child: Observer(builder: (_) {
                    return Stack(
                      children: [
                        (_authScreenStore.profileImage != null)
                            ? SimpleShadow(
                          color: Colors.black12,
                          offset: const Offset(0, 4), // Default: Offset(2, 2)
                          sigma: 4,
                          child: CircularAvatarWithFileImage(
                            imagePath: _authScreenStore.profileImage!,
                            imageSize: 100,
                          ),
                        )
                            : CircularAvatarWithAssetImage(
                            imagePath: cartoonIcon, imageSize: 100),
                        Positioned(
                            right: 0,
                            bottom: 6,
                            child: CircularAvatarWithAssetImage(
                                imagePath: ic_cameraIcon, imageSize: 28)),
                      ],
                    );
                  }),
                ),
                verticalSpace(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: darkGreyColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: regularWhiteText16(Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _signUpNameKey,
                              child: SizedBox(
                                width: Get.width,
                                child: OnBoardingTextFieldWidget(
                                  validation: _customValidator.validatename,
                                  controller: _authScreenStore.nameController,
                                  // onChanged: (e) {
                                  //   _authScreenStore.validateSignUpPage(
                                  //     _signUpNameKey,
                                  //     ValidationChecker.name,
                                  //   );
                                  // },
                                  keyboard: TextInputType.text,
                                  passwordVisible: false,
                                  hintText: ' Input your name',
                                  image: ic_profileIcon,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 16),
                      Text(
                        "Phone Number",
                        style: regularWhiteText16(Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _signUpPhoneKey,
                              child: SizedBox(
                                width: Get.width,
                                child: OnBoardingTextFieldWidget1(
                                  validation: _customValidator.validateMobile,
                                  controller:
                                  _authScreenStore.phoneNumberController,
                                  // onChanged: (e) {
                                  //   _authScreenStore.validateSignUpPage(
                                  //     _signUpPhoneKey,
                                  //     ValidationChecker.phone,
                                  //   );
                                  // },
                                  keyboard: TextInputType.number,
                                  passwordVisible: false,
                                  hintText: ' Input your Phone Number',
                                  image: ic_callIcon,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 16),
                      Text(
                        "Email",
                        style: regularWhiteText16(Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      verticalSpace(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _signUpEmailKey,
                              child: SizedBox(
                                width: Get.width,
                                child: OnBoardingTextFieldWidget(
                                  validation: _customValidator.validateEmail,
                                  controller: _authScreenStore.emailController,
                                  // onChanged: (e) {
                                  //   _authScreenStore.validateSignUpPage(
                                  //     _signUpEmailKey,
                                  //     ValidationChecker.email,
                                  //   );
                                  // },
                                  keyboard: TextInputType.text,
                                  passwordVisible: false,
                                  hintText: ' Input your email address',
                                  image: ic_mailIcon,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                            child: Form(
                              key: _signUpPasswordKey,
                              child: SizedBox(
                                width: Get.width,
                                child: OnBoardingTextFieldWidget(
                                  validation: _customValidator.validatePassword,
                                  controller: _authScreenStore.passwordController,
                                  keyboard: TextInputType.text,
                                  passwordVisible: eyeIcon,
                                  hintText: ' Input your password',
                                  image: ic_lockIcon,
                                  suffixxIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        eyeIcon = !eyeIcon;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:eyeIcon ? Image.asset(hiddenPassword,scale: 4,):Icon(
                                        Icons.remove_red_eye_outlined,
                                        size: 22,
                                        color: lightGreyColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 16),
                      Text(
                        "Referral Code",
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
                                controller: _authScreenStore.referralCodeController,
                                keyboard: TextInputType.text,
                                passwordVisible: false,
                                hintText: ' Input your code',
                                image: referralCodeIcon,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(height: 8),
                    ],
                  ),
                ),
                verticalSpace(height: 24),
                GestureDetector(
                  onTap: () {
                    _signUpUser();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: blueAppColor,
                        borderRadius: BorderRadius.circular(16)),
                    child: CustomizedButton(
                      buttonHeight: 48,
                      buttonWidth: Get.width,
                      text: 'Sign Up',
                      textStyle: regularWhiteText16(whiteContainerColor),
                    ),
                  ),
                ),
                verticalSpace(height: 16),
              ],
            ),
          ),
        ),
        GenericProgressBar(tag: NamedRoutes.routeSignUpScreen)
      ],
    );
  }
}
