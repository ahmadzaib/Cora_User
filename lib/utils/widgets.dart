// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:coraapp/utils/constants.dart';
import 'package:coraapp/utils/styles.dart';
import 'package:coraapp/utils/utils.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/apiControllers/api_controller.dart';
import 'colors.dart';
import 'decorations.dart';
import 'images.dart';

class MyScaffold extends StatelessWidget {
  final Widget? body, drawer, bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color backgroundColor;
  final Key? scaffoldKey;
  bool? resizeToAvoidBottomInset = true, extendBody, extendBodyBehindAppBar;

  MyScaffold({
    Key? key,
    this.body,
    this.drawer,
    this.appBar,
    this.bottomNavigationBar,
    required this.backgroundColor,
    this.scaffoldKey,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: body,
      drawer: drawer,
      bottomNavigationBar: bottomNavigationBar,
      extendBody: extendBody!,
      extendBodyBehindAppBar: extendBodyBehindAppBar!,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, this.color = buttonColor, this.title, this.onTap})
      : super(key: key);
  Color? color;
  Widget? title;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: const StadiumBorder(),
      child: ListTile(
        onTap: onTap,
        dense: true,
        shape: const StadiumBorder(),
        tileColor: color,
        title: title,
      ),
    );
  }
}

class CircularAvatarWithAssetImage extends StatelessWidget {
  final String imagePath;
  final double imageSize, imageWidth, imageHeight;
  var fit;

  CircularAvatarWithAssetImage({
    Key? key,
    required this.imagePath,
    required this.imageSize,
    this.imageWidth = 0.0,
    this.imageHeight = 0.0,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (imageWidth > 0) ? imageWidth : imageSize,
      height: (imageHeight > 0) ? imageHeight : imageSize,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(imageSize),
          child: Image.asset(
            imagePath,
            fit: fit,
          )),
    );
  }
}

class CircularAvatarWithFileImage extends StatelessWidget {
  final File imagePath;
  final double imageSize, imageWidth, imageHeight;
  var fit;

  CircularAvatarWithFileImage({
    Key? key,
    required this.imagePath,
    required this.imageSize,
    this.imageWidth = 0.0,
    this.imageHeight = 0.0,
    this.fit = BoxFit.fill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (imageWidth > 0) ? imageWidth : imageSize,
      height: (imageHeight > 0) ? imageHeight : imageSize,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(imageSize),
          child: Image.file(
            imagePath,
            fit: fit,
          )),
    );
  }
}

class CircularAvatar extends StatelessWidget {
  final String imagePath;
  final double imageSize, imageWidth, imageHeight;

  const CircularAvatar({
    Key? key,
    required this.imagePath,
    required this.imageSize,
    this.imageWidth = 0.0,
    this.imageHeight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (imageWidth > 0) ? imageWidth : imageSize,
      height: (imageHeight > 0) ? imageHeight : imageSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageSize),
        child: GenericCachedNetworkImage(
          imagePath: imagePath,
        ),
      ),
    );
  }
}

class CustomizedTouchEventIconButton extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final VoidCallback callback;
  final color;

  const CustomizedTouchEventIconButton(
      {Key? key,
      required this.path,
      required this.width,
      required this.height,
      this.color = null,
      required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        path,
        width: width,
        height: height,
        color: color,
      ),
      onPressed: callback,
    );
  }
}

class GenericCachedNetworkImage extends StatelessWidget {
  final String imagePath;

  const GenericCachedNetworkImage({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (_, url) => const PlaceholderWidget(),
      errorWidget: (_, url, error) => const PlaceholderWidget(),
      fit: BoxFit.cover,
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/cartoonIcon.png',
      fit: BoxFit.fill,
    );
  }
}

class CustomizedButton extends StatelessWidget {
  final String text, text2;
  final String imgb;
  final String imgf;
  final double verticalPadding;
  final Color textColor;
  final double buttonWidth;
  final double buttonHeight;
  final Color? imageColor;
  final double imageHeight;
  final double imageWidth, spaceBetweenImgText;

  final TextStyle? textStyle, textStyle2;

  const CustomizedButton(
      {Key? key,
      required this.text,
      this.text2 = '',
      this.verticalPadding = 0,
      this.textColor = Colors.white,
      this.imgf = '',
      this.imgb = '',
      this.buttonWidth = 174,
      this.buttonHeight = 44,
      this.imageHeight = 20,
      this.imageWidth = 20,
      this.textStyle,
      this.textStyle2,
      this.imageColor,
      this.spaceBetweenImgText = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: verticalPadding),
        child: SizedBox(
          height: buttonHeight,
          width: buttonWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isEmpty(imgb)
                  ? Container()
                  : Row(
                      children: [
                        Image.asset(
                          imgb,
                          height: imageHeight,
                          width: imageWidth,
                          color: imageColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
              horizontalSpace(width: spaceBetweenImgText),
              Row(
                children: [
                  Text(
                    text,
                    style: textStyle,
                  ),
                  isEmpty(text2)
                      ? Container()
                      : Text(
                          text2,
                          style: textStyle2,
                        ),
                ],
              ),
              isEmpty(imgf)
                  ? Container()
                  : Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          imgf,
                          height: imageHeight,
                          width: imageWidth,
                          color: imageColor,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CutomizedTextField extends StatelessWidget {
  String sufixImage, hintText;
  bool passwordVisible;
  TextInputType? keyboard;
  String? textlimit;
  TextEditingController? descriptionController;
  final FormFieldValidator<String>? validator;

  // final Function(bool)? callbackFocus;
  void Function(String? data)? saveData;
  int maxlines;
  int? max, maxChar;
  bool autoFocus;
  Color hintColor, shadowColor, textStyleColor;

  CutomizedTextField({
    Key? key,
    required this.passwordVisible,
    required this.keyboard,
    this.textlimit,
    this.max,
    this.hintColor = textFormFieldColor,
    this.shadowColor = Colors.black26,
    this.descriptionController,
    this.textStyleColor = Colors.black,
    this.sufixImage = "",
    this.hintText = "",
    required this.saveData,
    this.maxlines = 1,
    this.validator,
    this.maxChar,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 1,
      // Default: 0.5
      color: shadowColor,
      offset: const Offset(0, 0),
      // Default: Offset(2, 2)
      sigma: 1,
      child: TextFormField(
        cursorColor: Colors.black,
        style: TextStyle(
            color: textStyleColor, decorationThickness: 0, fontSize: 14),
        autofocus: autoFocus,
        maxLines: maxlines,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        validator: validator,
        maxLength: max,
        controller: descriptionController,
        keyboardType: keyboard,
        obscureText: passwordVisible,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintStyle: TextStyle(
            color: hintColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(),
          // suffixIcon: (sufixImage.isNotEmpty)
          //     ? Image.asset(
          //       sufixImage,
          //       height: 6,
          //       width: 12,
          //     )
          //     : null,
        ),
        onSaved: saveData,
        onChanged: (value) {},
        // buildCounter: (context, {required currentLength,required isFocused, maxLength}) {
        //   return Text('');
        // },
      ),
    );
  }
}

class CutomizedSearchTextField extends StatelessWidget {
  String prefixImage, hintText;
  Widget? suffixxIcon;
  Widget? suffixImage;
  bool passwordVisible, isBorderRequired;

  TextInputType? keyboard;
  TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  // final Function(bool)? callbackFocus;
  void Function(String? data)? saveData;
  void Function(String? data)? onChangedValue;
  int maxlines;
  final int maxLength;
  bool autoFocus, enable, couponCodeBox, readOnly;
  Color filledColor;

  EdgeInsetsGeometry padding, contentPadding;
  dynamic prefixImageHeight, prefixImageWidth;
  TextStyle hintStyle, style;

  CutomizedSearchTextField({
    Key? key,
    this.hintStyle = const TextStyle(
      color: brightestBlue,
      decorationThickness: 0,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    this.isBorderRequired = false,
    this.padding =
        const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
    required this.passwordVisible,
    required this.keyboard,
    this.contentPadding =
        const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    this.controller,
    this.prefixImageHeight = 20.0,
    this.prefixImageWidth = 20.0,
    this.couponCodeBox = false,
    this.prefixImage = "",
    this.readOnly = false,
    this.suffixImage,
    this.maxlines = 1,
    this.enable = true,
    this.hintText = "",
    this.style = const TextStyle(color: Colors.black),
    required this.saveData,
    this.validator,
    this.autoFocus = false,
    this.filledColor = searchBarColor,
    this.onChangedValue,
    this.maxLength = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      // Default: 0.5,
      color: Colors.black12,
      offset: const Offset(0, 8), // Default: Offset(2, 2)
      sigma: 4,
      child: TextFormField(
        readOnly: readOnly,
        enabled: enable,
        maxLines: maxlines,
        autofocus: autoFocus,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        validator: validator,
        controller: controller,
        style: regularWhiteText14(darkBlackColor, fontWeight: FontWeight.w500),
        keyboardType: keyboard,
        obscureText: passwordVisible,
        cursorColor: Colors.black,
        maxLength: maxLength,

        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: whiteContainerColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: contentPadding,
          constraints: BoxConstraints(),
          hintStyle: hintStyle,
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(),
          prefixIcon: (prefixImage.isNotEmpty)
              ? SizedBox(
                  width: 42,
                  child: Row(
                    children: [
                      Padding(
                        padding: padding,
                        child: Image.asset(
                          prefixImage,
                          height: prefixImageHeight,
                          width: prefixImageWidth,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: .5,
                        color: lightGreyColor.withOpacity(.8),
                      )
                    ],
                  ),
                )
              : SizedBox(),
          suffixIcon: suffixImage,
          counterText: "",
        ),
        onSaved: saveData,
        onChanged: onChangedValue,
        // onChanged: (value) {
        //   _password = value;
        // },
      ),
    );
  }
}

class CutomizedSearchTextField2 extends StatelessWidget {
  String prefixImage, hintText;
  Widget? suffixxIcon;
  Widget? suffixImage;
  bool passwordVisible, isBorderRequired;

  TextInputType? keyboard;
  TextEditingController? descriptionController;
  final FormFieldValidator<String>? validator;

  // final Function(bool)? callbackFocus;
  void Function(String? data)? saveData;
  void Function(String? data)? onChangedValue;
  int maxlines;
  bool autoFocus, enable;
  Color filledColor;
  EdgeInsetsGeometry padding, contentPadding;
  dynamic prefixImageHeight, prefixImageWidth;
  TextStyle hintStyle, style;

  CutomizedSearchTextField2({
    Key? key,
    this.hintStyle = const TextStyle(
      color: brightestBlue,
      decorationThickness: 0,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    this.isBorderRequired = false,
    this.padding =
        const EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
    required this.passwordVisible,
    required this.keyboard,
    this.contentPadding =
        const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    this.descriptionController,
    this.prefixImageHeight = 20.0,
    this.prefixImageWidth = 20.0,
    this.prefixImage = "",
    this.suffixImage,
    this.maxlines = 1,
    this.enable = true,
    this.hintText = "",
    this.style = const TextStyle(color: Colors.black),
    required this.saveData,
    this.validator,
    this.autoFocus = false,
    this.filledColor = searchBarColor,
    this.onChangedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      // Default: 0.5
      color: Colors.black12,
      offset: const Offset(0, 8), // Default: Offset(2, 2)
      sigma: 4,
      child: TextFormField(
        cursorColor: Colors.black,
        enabled: enable,
        maxLines: maxlines,
        autofocus: autoFocus,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        validator: validator,
        controller: descriptionController,
        keyboardType: keyboard,
        obscureText: passwordVisible,

        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: whiteContainerColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: contentPadding,
          constraints: BoxConstraints(),
          hintStyle: hintStyle,
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(),
        ),
        style: style,
        onSaved: saveData,
        onChanged: onChangedValue,
        // onChanged: (value) {
        //   _password = value;
        // },
      ),
    );
  }
}

class GenericCard extends StatelessWidget {
  const GenericCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 13,
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Image.asset(
        'assets/images/ic_circular_logo.png',
        height: 96,
        width: 96,
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  final Color drawerColor;
  final Color logoColor;

  double logoHieght;

  HomeAppBar({
    Key? key,
    this.logoHieght = .088,
    this.drawerColor = Colors.white,
    this.logoColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ExpandTapWidget(
          tapPadding: EdgeInsets.all(10),
          onTap: () {},
          child: Container(
            child: Image.asset(
              "assets/images/ic_setting.png",
              height: 25,
              width: 25,
            ),
          ),
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/ic_logo.png',
              height: 25,
              width: 35,
              color: fieldColor,
            ),
          ],
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/ic_profile_dot.png',
              height: 25,
              width: 28,
            ),
          ],
        ),
      ],
    );
  }
}

class MySecondAppBar extends StatelessWidget {
  MySecondAppBar({
    this.appbarText1 = '',
    this.appbarText = '',
    this.appbarLogo = '',
    this.appbarRightLogo = '',
    this.istrue = true,
    this.color = brightestBlue,
    required this.onPress,
    this.textStyleRight,
    this.require20 = false,
    this.isNewScreenRequired = false,
    this.isMenu = false,
    this.appbarIcon2NotificationNumber = '7',
    this.isBackButtonRequired = true,
    // this.onpressRight,
    this.fontStyle = FontStyle.italic,
    Key? key,
  }) : super(key: key);
  String appbarLogo, appbarText, appbarText1, appbarRightLogo;

  Color color;
  bool require20, istrue, isNewScreenRequired, isMenu, isBackButtonRequired;
  VoidCallback onPress;
  dynamic fontStyle;
  String appbarIcon2NotificationNumber;
  TextStyle? textStyleRight;

  // Function()? onpressRight;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: istrue
          ? EdgeInsets.symmetric(horizontal: 16)
          : EdgeInsets.only(left: 16, right: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (isBackButtonRequired)
                  ? ExpandTapWidget(
                      tapPadding: EdgeInsets.all(30),
                      onTap: () {
                        if (isNewScreenRequired) {
                          Get.toNamed(NamedRoutes.routeMenuScreen);
                        } else {
                          Get.close(1);
                        }
                      },
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 8)),
                          ],
                          color: whiteContainerColor,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: isNewScreenRequired ? 10 : 17,
                            vertical: isNewScreenRequired ? 10 : 14),
                        child: Center(
                          child: Image.asset(
                            appbarLogo,
                            color: backIconColor,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 44,
                      width: 44,
                    ),
              (appbarText.isNotEmpty)
                  ? Text(
                      appbarText,
                      style: regularWhiteText22(Colors.black,
                          fontStyle: fontStyle, fontWeight: FontWeight.w500),
                    )
                  : GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        "assets/images/applogo.png",
                        height: 20,
                        width: 80,
                      )),
              (appbarRightLogo.isNotEmpty)
                  ? ExpandTapWidget(
                      tapPadding: EdgeInsets.all(30),
                      onTap: (() {
                        Get.toNamed(NamedRoutes.routeNotificationScreen);
                      }),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 8)),
                          ],
                          color: whiteContainerColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 11, vertical: 10),
                        child: Image.asset(
                          appbarRightLogo,
                          height: 20,
                          width: 18,
                          fit: BoxFit.cover,
                          color: backIconColor,
                        ),
                      ),
                    )
                  : Container(
                      width: 44,
                      height: 44,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  bool obscureText;
  bool readOnly;
  TextEditingController? controller;
  int textLength;
  int? minLines;
  int? maxLines;
  TextInputType keyboardType;
  TextAlign textAlign;
  String? hint;
  String? text;
  FocusNode? focus;
  double verticalPad, horizontalPad;
  final Function(String)? onChanged;

  MyTextField({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.textLength = 100,
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.hint,
    this.text,
    this.focus,
    this.verticalPad = 0.0,
    this.horizontalPad = 0.0,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        cursorColor: Colors.black,
        initialValue: text,
        decoration: densedFieldDecorationWithoutPadding(
          hint: hint,
          verticalPad: verticalPad,
          horizontalPad: horizontalPad,
        ),
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: textAlign,
        maxLength: textLength,
        minLines: minLines,
        maxLines: maxLines,
        controller: controller,
        focusNode: focus,
        readOnly: readOnly,
      ),
    );
  }
}

class AnimatedContainerWrapper extends StatelessWidget {
  const AnimatedContainerWrapper({
    Key? key,
    required this.closedBuilder,
    required this.openBuilder,
    required this.transitionType,
    required this.onClosed,
  }) : super(key: key);

  final Widget closedBuilder;
  final Widget openBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      closedColor: Colors.transparent,
      openElevation: 0,
      closedElevation: 0,
      transitionType: transitionType,
      openBuilder: (_, v) => openBuilder,
      onClosed: onClosed,
      tappable: true,
      closedBuilder: (_, v) => closedBuilder,
    );
  }
}

class FadeIndexedStack extends StatefulWidget {
  final int index;
  final List<Widget> children;
  final Duration duration;

  const FadeIndexedStack({
    Key? key,
    required this.index,
    required this.children,
    this.duration = const Duration(
      milliseconds: 300,
    ),
  }) : super(key: key);

  @override
  _FadeIndexedStackState createState() => _FadeIndexedStackState();
}

class _FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );
  }
}

class HideScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

BoxDecoration backgroundImage() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/ic_background.png'),
      fit: BoxFit.fill,
    ),
  );
}

Widget cardList(String img, String name, String disc) {
  return Expanded(
    child: Container(
      child: ListTile(
        leading: Image.asset(
          img,
          scale: 3,
        ),
        title: Text(
          name,
          style: TextStyle(color: Colors.black, fontSize: Get.width * 0.045),
        ),
        trailing: Text(
          disc,
          style: TextStyle(
              color: Colors.grey.withOpacity(0.30),
              fontSize: Get.width * 0.035),
        ),
      ),
    ),
  );
}

class MyCustomizedDivider extends StatelessWidget {
  MyCustomizedDivider(
      {Key? key, this.color = webTextCollor, this.height = .001})
      : super(key: key);
  Color color;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * height,
      width: Get.width,
      color: color,
    );
  }
}

class MyDivider extends StatelessWidget {
  MyDivider({Key? key, this.color = webTextCollor, this.height = .0006})
      : super(key: key);
  Color color;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * height,
      width: Get.width,
      color: color,
    );
  }
}

class DeliveryInfoWidget extends StatefulWidget {
  const DeliveryInfoWidget({
    Key? key,
    required this.title,
    required this.detail,
    required this.islinkLineRequired,
    this.isPaymentMethod = false,
    this.icon = '',
  }) : super(key: key);
  final String title, detail, icon;
  final bool islinkLineRequired, isPaymentMethod;

  @override
  State<DeliveryInfoWidget> createState() => _DeliveryInfoWidgetState();
}

class _DeliveryInfoWidgetState extends State<DeliveryInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: blueAppColor)),
            ),
            horizontalSpace(width: 12),
            Expanded(
                child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
              style: regularWhiteText16(darkBlackColor,
                  fontWeight: FontWeight.w500),
            )),
          ],
        ),
        verticalSpace(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 20,
              child: (widget.islinkLineRequired)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          width: 1,
                          color: lightGreyColor.withOpacity(.8),
                        ),
                      ],
                    )
                  : SizedBox(),
            ),
            horizontalSpace(width: 12),
            (widget.isPaymentMethod)
                ? Image.asset(
                    widget.icon,
                    height: 16,
                    width: 22,
                  )
                : Container(),
            horizontalSpace(width: (widget.isPaymentMethod) ? 12 : 0),
            Expanded(
                flex: 2,
                child: Text(
                  (widget.isPaymentMethod)
                      ? "...${widget.detail}"
                      : '${widget.detail} \n',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: regularWhiteText13(lightGreyColor),
                )),
            Expanded(child: SizedBox()),
          ],
        ),
      ],
    );
  }
}

class OnBoardingTextFieldWidget extends StatelessWidget {
  String? hintText;
  bool passwordVisible;
  final bool? readOnly;
  Widget? suffixxIcon;
  TextInputType? keyboard;
  TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  final int? maxLength;
  void Function(String? data)? onChanged;
  String image;

  OnBoardingTextFieldWidget({
    Key? key,
    this.hintText,
    this.suffixxIcon,
    this.keyboard,
    required this.passwordVisible,
    this.controller,
    this.onChanged,
    this.validation,
    this.image = '',
    this.maxLength = 40,
    this.readOnly = false,
  }) : super(key: key);

  void Function(String? data)? saveData;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: Colors.black12,
      offset: const Offset(0, 8), // Default: Offset(2, 2)
      sigma: 4,
      child: TextFormField(
        cursorColor: Colors.black,
        validator: validation,
        controller: controller,
        onChanged: onChanged,
        onSaved: saveData,
        readOnly: readOnly!,
        maxLength: maxLength,
        autofocus: false,
        obscureText: passwordVisible,
        style: regularWhiteText14(darkBlackColor, fontWeight: FontWeight.w500),
        keyboardType: keyboard,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixxIcon,
          hintStyle: regularWhiteText14(lightGreyColor),
          // remove all border
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),

          contentPadding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          // apply borderRadius

          prefixIcon: isNotEmpty(image)
              ? SizedBox(
                  width: 42,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Image.asset(
                          image,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: .5,
                        color: lightGreyColor.withOpacity(.8),
                      )
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class OnBoardingTextFieldWidget1 extends StatelessWidget {
  String? hintText;
  bool passwordVisible;
  Widget? suffixxIcon;
  TextInputType? keyboard;
  TextEditingController? controller;
  final FormFieldValidator<String>? validation;
  void Function(String? data)? onChanged;
  String image;

  OnBoardingTextFieldWidget1({
    Key? key,
    this.hintText,
    this.suffixxIcon,
    this.keyboard,
    required this.passwordVisible,
    this.controller,
    this.onChanged,
    this.validation,
    this.image = '',
  }) : super(key: key);

  void Function(String? data)? saveData;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: Colors.black12,
      offset: const Offset(0, 8), // Default: Offset(2, 2)
      sigma: 4,
      child: TextFormField(
        cursorColor: Colors.black,
        validator: validation,
        controller: controller,
        onChanged: onChanged,
        onSaved: saveData,
        autofocus: false,
        obscureText: passwordVisible,
        maxLength: 10,
        style: regularWhiteText14(darkBlackColor, fontWeight: FontWeight.w500),
        // style: TextStyle(
        //     decorationThickness: 0,
        //     fontSize: 13,
        //     color: darkBlackColor,
        //     fontWeight: FontWeight.w500),
        keyboardType: keyboard,
        decoration: InputDecoration(
          counterText: "",
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          suffixIcon: suffixxIcon,
          hintStyle: regularWhiteText14(lightGreyColor),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: EdgeInsets.only(left: 20, bottom: 10, top: 10),
          // apply borderRadius
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(12),
          ),
          prefixIcon: isNotEmpty(image)
              ? SizedBox(
                  width: 85,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Image.asset(
                          image,
                          height: 20,
                          width: 20,
                        ),
                      ),
                      Container(
                        height: 20,
                        width: .5,
                        color: lightGreyColor.withOpacity(.8),
                      ),
                      horizontalSpace(width: 8),
                      Text(
                        "+234",
                        style: regularWhiteText14(darkBlackColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class OrderDetailWidget extends StatelessWidget {
  OrderDetailWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.disc,
    this.sizeOfLine = false,
    this.visibleLine = false,
  }) : super(key: key);
  String title;
  Color color;
  bool disc = false;
  bool sizeOfLine;
  bool visibleLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: regularWhiteText13(darkBlackColor),
                ),
              ),
              // horizontalSpace(width: 16),
              Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              // Column(
              //   children: [
              //
              //
              //     (visibleLine == true)?
              //     Expanded(
              //       child: Container(
              //
              //         width: 2,
              //         color: lightGreyColor,
              //       ),
              //     ):SizedBox(),
              //   ],
              // ),
              horizontalSpace(width: 30),
              (disc == true)
                  ? Expanded(
                      flex: 3,
                      child: Text(
                        "Sun, 23th Oct '22 01:46 Am",
                        style: regularWhiteText13(darkBlackColor),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //
                      //
                      //     verticalSpace(),
                      //     Text("Your Order has been placed",style: regularWhiteText13(darkBlackColor),),
                      //
                      //   ],
                      // ),
                    )
                  : Expanded(flex: 3, child: SizedBox()),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '',
                  textAlign: TextAlign.start,
                  style: regularWhiteText13(darkBlackColor),
                ),
              ),
              horizontalSpace(width: 3),
              (visibleLine)
                  ? Container(
                      height: (sizeOfLine) ? 50 : 30,
                      width: 2,
                      color: lightGreyColor,
                    )
                  : SizedBox(),
              horizontalSpace(width: 33),
              (disc == true)
                  ? Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          "Your order has been placed.",
                          style: regularWhiteText13(darkBlackColor),
                        ),
                      ),

                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //
                      //
                      //     verticalSpace(),
                      //     Text("Your Order has been placed",style: regularWhiteText13(darkBlackColor),),
                      //
                      //   ],
                      // ),
                    )
                  : Expanded(flex: 3, child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }
}

// class OrderDetailWidget extends StatelessWidget {
//   OrderDetailWidget({Key? key,required this.title,
//     required this.color,
//     required this.disc,
//     this.sizeOfLine,
//     this.visibleLine,
//
//   }) : super(key: key);
//   String title;
//   Color color;
//   bool  disc = false;
//   bool? sizeOfLine = false;
//   bool? visibleLine = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                   width: 70,
//                   child: Text(title,style: regularWhiteText13(darkBlackColor),)),
//               horizontalSpace(width: 16),
//               Column(
//                 children: [
//                   Container(
//                     height: 8,
//                     width: 8,
//                     decoration: BoxDecoration(
//                         color: color,
//                         shape: BoxShape.circle
//                     ),
//
//                   ),
//                   (visibleLine == true)?
//                   Container(
//                     height:(sizeOfLine == true)?60:40,
//                     width: 2,
//                     color: lightGreyColor,
//                   ):SizedBox(),
//                 ],
//               ),
//               horizontalSpace(width: 30),
//               (disc == true)?
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Sun, 23th Oct '22 01:46 Am",style: regularWhiteText13(darkBlackColor),),
//                   verticalSpace(),
//                   Text("Your Order has been placed",style: regularWhiteText13(darkBlackColor),),
//
//                 ],
//               ):SizedBox(),
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
class GenericProgressBar extends StatelessWidget {
  final String tag;

  const GenericProgressBar({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    APIController controller = Get.find(tag: tag);
    return Obx(() {
      return (controller.isLoading.value)
          ? AbsorbPointer(
              child: Container(
                width: Get.width,
                height: Get.height,
                child: const Center(
                    child: CircularProgressIndicator(
                  color: blueAppColor,
                  strokeWidth: 2,
                )),
              ),
            )
          : Container();
    });
  }
}

class MyCustomScrollBar extends StatelessWidget {
  final Axis axis;
  final ScrollController? controller;
  final Widget child;
  final physics;

  const MyCustomScrollBar({
    Key? key,
    this.axis = Axis.vertical,
    this.physics,
    this.controller,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: axis,
        controller: controller,
        child: child,
        physics: physics,
      ),
    );
  }
}

class PullDownToRefresh extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback onRefresh;
  final Widget child;

  const PullDownToRefresh(
      {Key? key,
      required this.controller,
      required this.onRefresh,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
