import 'package:flutter/material.dart';

class CustomFormHelper {
  void unfocusFormFields(BuildContext context) {
    try {
      FocusScope.of(context).unfocus();
      Focus.of(context).unfocus();
    } catch (_) {}
  }

  void checkfocus(BuildContext context, currentFocus) {
    try {
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        currentFocus.focusedChild?.unfocus();
      }
    } catch (_) {}
  }
}
