// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthScreenStore on _AuthScreenStore, Store {
  late final _$isLoginAtom =
      Atom(name: '_AuthScreenStore.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$phoneNumberControllerAtom =
      Atom(name: '_AuthScreenStore.phoneNumberController', context: context);

  @override
  TextEditingController get phoneNumberController {
    _$phoneNumberControllerAtom.reportRead();
    return super.phoneNumberController;
  }

  @override
  set phoneNumberController(TextEditingController value) {
    _$phoneNumberControllerAtom.reportWrite(value, super.phoneNumberController,
        () {
      super.phoneNumberController = value;
    });
  }

  late final _$nameControllerAtom =
      Atom(name: '_AuthScreenStore.nameController', context: context);

  @override
  TextEditingController get nameController {
    _$nameControllerAtom.reportRead();
    return super.nameController;
  }

  @override
  set nameController(TextEditingController value) {
    _$nameControllerAtom.reportWrite(value, super.nameController, () {
      super.nameController = value;
    });
  }

  late final _$emailControllerAtom =
      Atom(name: '_AuthScreenStore.emailController', context: context);

  @override
  TextEditingController get emailController {
    _$emailControllerAtom.reportRead();
    return super.emailController;
  }

  @override
  set emailController(TextEditingController value) {
    _$emailControllerAtom.reportWrite(value, super.emailController, () {
      super.emailController = value;
    });
  }

  late final _$passwordControllerAtom =
      Atom(name: '_AuthScreenStore.passwordController', context: context);

  @override
  TextEditingController get passwordController {
    _$passwordControllerAtom.reportRead();
    return super.passwordController;
  }

  @override
  set passwordController(TextEditingController value) {
    _$passwordControllerAtom.reportWrite(value, super.passwordController, () {
      super.passwordController = value;
    });
  }

  late final _$referralCodeControllerAtom =
      Atom(name: '_AuthScreenStore.referralCodeController', context: context);

  @override
  TextEditingController get referralCodeController {
    _$referralCodeControllerAtom.reportRead();
    return super.referralCodeController;
  }

  @override
  set referralCodeController(TextEditingController value) {
    _$referralCodeControllerAtom
        .reportWrite(value, super.referralCodeController, () {
      super.referralCodeController = value;
    });
  }

  late final _$nameValidationAtom =
      Atom(name: '_AuthScreenStore.nameValidation', context: context);

  @override
  bool get nameValidation {
    _$nameValidationAtom.reportRead();
    return super.nameValidation;
  }

  @override
  set nameValidation(bool value) {
    _$nameValidationAtom.reportWrite(value, super.nameValidation, () {
      super.nameValidation = value;
    });
  }

  late final _$phoneValidationAtom =
      Atom(name: '_AuthScreenStore.phoneValidation', context: context);

  @override
  bool get phoneValidation {
    _$phoneValidationAtom.reportRead();
    return super.phoneValidation;
  }

  @override
  set phoneValidation(bool value) {
    _$phoneValidationAtom.reportWrite(value, super.phoneValidation, () {
      super.phoneValidation = value;
    });
  }

  late final _$emailValidationAtom =
      Atom(name: '_AuthScreenStore.emailValidation', context: context);

  @override
  bool get emailValidation {
    _$emailValidationAtom.reportRead();
    return super.emailValidation;
  }

  @override
  set emailValidation(bool value) {
    _$emailValidationAtom.reportWrite(value, super.emailValidation, () {
      super.emailValidation = value;
    });
  }

  late final _$passwordValidationAtom =
      Atom(name: '_AuthScreenStore.passwordValidation', context: context);

  @override
  bool get passwordValidation {
    _$passwordValidationAtom.reportRead();
    return super.passwordValidation;
  }

  @override
  set passwordValidation(bool value) {
    _$passwordValidationAtom.reportWrite(value, super.passwordValidation, () {
      super.passwordValidation = value;
    });
  }

  late final _$profileImageAtom =
      Atom(name: '_AuthScreenStore.profileImage', context: context);

  @override
  File? get profileImage {
    _$profileImageAtom.reportRead();
    return super.profileImage;
  }

  @override
  set profileImage(File? value) {
    _$profileImageAtom.reportWrite(value, super.profileImage, () {
      super.profileImage = value;
    });
  }

  late final _$_AuthScreenStoreActionController =
      ActionController(name: '_AuthScreenStore', context: context);

  @override
  dynamic validateSignUpForm(ValidationChecker index, bool value) {
    final _$actionInfo = _$_AuthScreenStoreActionController.startAction(
        name: '_AuthScreenStore.validateSignUpForm');
    try {
      return super.validateSignUpForm(index, value);
    } finally {
      _$_AuthScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  GlobalKey<State<StatefulWidget>> validateSignUpPage(
      dynamic formKey, ValidationChecker validationChecker) {
    final _$actionInfo = _$_AuthScreenStoreActionController.startAction(
        name: '_AuthScreenStore.validateSignUpPage');
    try {
      return super.validateSignUpPage(formKey, validationChecker);
    } finally {
      _$_AuthScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLogin: ${isLogin},
phoneNumberController: ${phoneNumberController},
nameController: ${nameController},
emailController: ${emailController},
passwordController: ${passwordController},
referralCodeController: ${referralCodeController},
nameValidation: ${nameValidation},
phoneValidation: ${phoneValidation},
emailValidation: ${emailValidation},
passwordValidation: ${passwordValidation},
profileImage: ${profileImage}
    ''';
  }
}
