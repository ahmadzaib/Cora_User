// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'colors.dart';

class CutomizedTextField4 extends StatelessWidget {
  String prefixImage, hintText;
  bool passwordVisible;
  TextInputType? keyboard;
  TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  // final Function(bool)? callbackFocus;
  void Function(String? data)? saveData;
  bool autoFocus;

  CutomizedTextField4({
    Key? key,
    required this.passwordVisible,
    this.keyboard,
    this.controller,
    this.prefixImage = "",
    this.hintText = "",
    required this.saveData,
    this.validator,
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      opacity: 0.1, // Default: 0.5

      // offset: const Offset(1.5, 1.5), // Default: Offset(2, 2)
      sigma: 4,
      child: TextFormField(
        autofocus: autoFocus,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        textInputAction: TextInputAction.next,
        validator: validator,
        controller: controller,
        keyboardType: keyboard,
        obscureText: passwordVisible,
        cursorColor: appBarColor,
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          hintStyle: const TextStyle(
            color: textFormFieldColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          hintText: hintText,
          prefixIconConstraints: const BoxConstraints(),
          // prefixIcon: (prefixImage.isNotEmpty)
          //     ? Padding(
          //         padding: const EdgeInsets.only(
          //             top: 12.0, bottom: 12, left: 30, right: 12),
          //         child: Image.asset(
          //           prefixImage,
          //           height: 16,
          //           width: 16,
          //         ),
          //       )
          //     : ,
        ),
        onSaved: saveData,
        onChanged: (value) {},
      ),
    );
  }
}
