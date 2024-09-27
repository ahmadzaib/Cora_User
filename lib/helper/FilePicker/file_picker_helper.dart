// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../service_locator.dart';
import '../../store/auth_store.dart';
import '../../utils/colors.dart';
import '../../utils/function_response.dart';

class FilePickerHelper {
  FilePickerHelper(this.authScreenStore);
  final AuthScreenStore authScreenStore;
  final ImagePicker _picker = ImagePicker();

  Future<FunctionResponse> pickImageFromGallery(
      ImageSource source, BuildContext context,
      {bool isMultiImage = false}) async {
    FunctionResponse fResponce = getIt<FunctionResponse>();
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 100,
      );
      if (pickedFile != null) {
        CroppedFile croppedFile = await cropImage(context, pickedFile.path);

        if (croppedFile.path.isNotEmpty) {
          authScreenStore.profileImage = File(croppedFile.path);
        } else {
          authScreenStore.profileImage = File(pickedFile.path);
        }
        fResponce.passed(
          message: 'success',
        );
      } else {
        fResponce.failed(
          message: 'failed',
        );
      }
    } catch (e) {
      fResponce.failed(
        message: e.toString(),
      );
    }
    return fResponce;
  }

  Future<CroppedFile> cropImage(BuildContext context, imagePAth) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePAth,
      aspectRatio: CropAspectRatio(ratioX: 10.0, ratioY: 10.0),
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            cropFrameColor: blueAppColor,
            // cropGridColor: Colors.black,
            activeControlsWidgetColor: switcherBlue,
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            backgroundColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Crop',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    return croppedFile!;
  }
}
