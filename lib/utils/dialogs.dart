import 'package:flutter/material.dart';

enum DialogType { dialog, bottomSheet }

showFullWidthDialogBox(
    BuildContext context, Widget child, isCancelable, DialogType type,
    {hight = 0.50}) {
  if (type == DialogType.dialog) {
    showDialog(
      barrierDismissible: isCancelable,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: child,
      ),
    );
  } else {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      elevation: 0,
      context: context,
      isDismissible: isCancelable,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: hight,
        child: child,
      ),
    );
  }
}

showFullWidthDialog(BuildContext context, Widget child, isCancelable) {
  return showDialog(
    barrierDismissible: isCancelable,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: child,
    ),
  );
}

showDialogwith100(BuildContext context, Widget child, isCancelable) {
  showDialog(
    barrierDismissible: isCancelable,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: child,
    ),
  );
}

showDialogwithnoPadding(BuildContext context, Widget child, isCancelable) {
  showDialog(
    barrierDismissible: isCancelable,
    useSafeArea: false,
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      elevation: 0,
      child: child,
    ),
  );
}

// class TutorialOverlay extends ModalRoute<void> {
// @override
// Duration get transitionDuration => Duration(milliseconds: 500);

// @override
// bool get opaque => false;

// @override
// bool get barrierDismissible => false;

// @override
// Color get barrierColor => Colors.black.withOpacity(0.5);

// @override
// String get barrierLabel => null;

// @override
// bool get maintainState => true;

// @override
// Widget buildPage(
//   BuildContext context,
//   Animation<double> animation,
//   Animation<double> secondaryAnimation,
// ) {
//   // This makes sure that text and other content follows the material style
//   return Material(
//     type: MaterialType.transparency,
//     // make sure that the overlay content is not cut off
//     child: SafeArea(
//       child: _buildOverlayContent(context),
//     ),
//   );
// }
