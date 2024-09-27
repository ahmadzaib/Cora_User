import 'dart:io';

import 'package:coraapp/controllers/uiControllers/MainScreenController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/apiControllers/api_controller.dart';
import '../service_locator.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/custom_validator.dart';
import '../utils/decorations.dart';
import '../utils/form_helper.dart';
import '../utils/images.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';
import '../utils/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final CustomFormHelper _customFormHelper = getIt<CustomFormHelper>();
  late XFile _image;
  final picker = ImagePicker();

  late APIController apiController;
  late MainScreenController mainScreenController;

  var _nameController = TextEditingController(),
      _phNoController = TextEditingController(),
      _emailController = TextEditingController(),
      _changePasswordController = TextEditingController();

  var userProfileUrl = ''.obs;

  @override
  void initState() {
    super.initState();
    apiController =
        Get.put(APIController(), tag: NamedRoutes.routeEditProfileScreen);

    mainScreenController = Get.find<MainScreenController>();

    initializeUI();

    apiController.baseModel.listen((baseModel) {
      if ((baseModel.status!)) {
        if (baseModel.code == 'PROFILE_UPDATE') {
          showSnackBar('Your profile updated successfully', context);
          Get.offAllNamed(NamedRoutes.routeHomeScreen);
        } else if (baseModel.code == 'UPLOAD_IMAGE') {
          userProfileUrl.value = baseModel.data['profile_image'] ?? '';
          Get.find<APIController>(tag: NamedRoutes.routeHomeScreen)
              .webservice
              .apiCallFetchProfile({}, RxBool(false)).then((value) =>
                  Get.find<APIController>(tag: NamedRoutes.routeHomeScreen)
                      .baseModel
                      .value = value);
        }
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
                    appbarText: "Edit Profile",
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(height: 24),
                  Obx(() {
                    return Stack(
                      children: [
                        CircularAvatar(
                            imagePath: '${userProfileUrl.value}',
                            imageSize: 100),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                                onTap: () {
                                  _imgFromGallery();
                                },
                                child: CircularAvatarWithAssetImage(
                                    imagePath: ic_cameraIcon, imageSize: 36))),
                      ],
                    );
                  }),
                  verticalSpace(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: darkGreyColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name",
                          style: regularWhiteText16(Colors.black),
                        ),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: CutomizedSearchTextField(
                                controller: _nameController,
                                enable: true,
                                onChangedValue: (e) {},
                                keyboard: TextInputType.name,
                                passwordVisible: false,
                                saveData: ((data) {}),
                                hintStyle: TextStyle(
                                    color: darkGreyColorTextField,
                                    fontSize: 12,
                                    decorationThickness: 0),
                                hintText: ' Jonathan',
                                suffixImage: Image.asset(
                                  ic_editIcon,
                                  scale: 4.5,
                                ),
                                prefixImage: ic_profileIcon,
                                prefixImageWidth: 20.0,
                                prefixImageHeight: 20.0,
                                padding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8, right: 6),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(height: 20),
                        Text(
                          "Phone Number",
                          style: regularWhiteText16(Colors.black),
                        ),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: OnBoardingTextFieldWidget1(
                                controller: _phNoController,
                                // enable: true,
                                // onChangedValue: (e) {},
                                keyboard: TextInputType.number,
                                suffixxIcon: Image.asset(
                                  ic_editIcon,
                                  scale: 4.5,
                                ),
                                passwordVisible: false,
                                hintText: ' 58963248',
                                image: ic_callIcon,
                                // prefixImage: ic_callIcon,
                                // prefixImageWidth: 20.0,
                                // prefixImageHeight: 20.0,
                                // padding: EdgeInsets.only(
                                //     left: 10, top: 8, bottom: 8, right: 6),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(height: 20),
                        Text(
                          "Email",
                          style: regularWhiteText16(Colors.black),
                        ),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: CutomizedSearchTextField(
                                controller: _emailController,
                                enable: true,
                                onChangedValue: (e) {},
                                keyboard: TextInputType.name,
                                passwordVisible: false,
                                saveData: ((data) {}),
                                hintStyle: TextStyle(
                                    color: darkGreyColorTextField,
                                    fontSize: 12,
                                    decorationThickness: 0),
                                hintText: ' alma.lawson@example.com',
                                suffixImage: Image.asset(
                                  ic_editIcon,
                                  scale: 4.5,
                                ),
                                prefixImage: ic_mailIcon,
                                prefixImageWidth: 20.0,
                                prefixImageHeight: 20.0,
                                padding: EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8, right: 6),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(height: 20),
                        Text(
                          "Change Password",
                          style: regularWhiteText16(Colors.black),
                        ),
                        verticalSpace(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Visibility(
                                visible: true,
                                child: CutomizedSearchTextField(
                                  controller: _changePasswordController,
                                  enable: true,
                                  onChangedValue: (e) {},
                                  keyboard: TextInputType.name,
                                  passwordVisible: true,
                                  saveData: ((data) {}),
                                  hintStyle: TextStyle(
                                      color: darkGreyColorTextField,
                                      fontSize: 12,
                                      decorationThickness: 0),
                                  hintText: 'password',
                                  suffixImage: Image.asset(
                                    ic_editIcon,
                                    scale: 4.5,
                                  ),
                                  prefixImage: ic_lockIcon,
                                  prefixImageWidth: 20.0,
                                  prefixImageHeight: 20.0,
                                  padding: EdgeInsets.only(
                                      left: 10, top: 8, bottom: 8, right: 6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(height: 20),
                  GestureDetector(
                    onTap: () {
                      onTapDone();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: blueAppColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: CustomizedButton(
                        buttonHeight: 48,
                        buttonWidth: Get.width,
                        text: 'Done',
                        textStyle: regularWhiteText16(whiteContainerColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  verticalSpace(height: 20),
                ],
              ),
            ),
          ),
        ),
        GenericProgressBar(tag: NamedRoutes.routeEditProfileScreen)
      ],
    );
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;

        apiController.webservice
            .apiCallUploadImage(File(_image.path), apiController.isLoading)
            .then((value) => apiController.baseModel.value = value);
      } else {
        print('No image selected');
      }
    });
  }

  bool validateFields() {
    if (isEmpty(_nameController.text)) {
      showSnackBar('Please fill name', context);
    } else if (isEmpty(_phNoController.text)) {
      showSnackBar('Please fill phone number', context);
    } else if (isEmpty(_emailController.text)) {
      showSnackBar('Please fill email', context);
    } else if (!getIt<CustomValidator>()
        .validateEmailAddress(_emailController.text)) {
      showSnackBar('Provided email is invalid', context);
    } else {
      return true;
    }

    return false;
  }

  void onTapDone() {
    if (validateFields()) {
      var map = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': '+234${_phNoController.text}',
        'password': _changePasswordController.text
      };

      apiController.webservice
          .apiCallUpdateProfile(map, apiController.isLoading)
          .then((value) => apiController.baseModel.value = value);
    }
  }

  void initializeUI() {
    _nameController.text = '${mainScreenController.userModel.value.name}';
    _phNoController.text =
        '${mainScreenController.userModel.value.phone.toString().replaceAll('+234', '')}';
    _emailController.text = '${mainScreenController.userModel.value.email}';
    userProfileUrl.value =
        '${mainScreenController.userModel.value.profile_image}';
  }
}
