import 'dart:io';

import 'package:coraapp/models/Auth/login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../screen/signup_screen.dart';
import '../service_locator.dart';
import '../utils/function_response.dart';

part 'auth_store.g.dart';

class AuthScreenStore = _AuthScreenStore with _$AuthScreenStore;

abstract class _AuthScreenStore with Store {
  @observable
  bool isLogin = true;
  @observable
  TextEditingController phoneNumberController = TextEditingController();
  @observable
  TextEditingController nameController = TextEditingController();
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();
  @observable
  TextEditingController referralCodeController = TextEditingController();
  @observable
  bool nameValidation = false;
  @observable
  bool phoneValidation = false;
  @observable
  bool emailValidation = false;
  @observable
  bool passwordValidation = false;
  @observable
  File? profileImage;
  @observable
  LoginModel loginModel = LoginModel();

  @action
  validateSignUpForm(ValidationChecker index, bool value) {
    switch (index) {
      case ValidationChecker.name:
        nameValidation = value;
        break;
      case ValidationChecker.phone:
        phoneValidation = value;
        break;
      case ValidationChecker.email:
        emailValidation = value;
        break;
      case ValidationChecker.password:
        passwordValidation = value;
        break;
      default:
        return;
    }
  }

  @action
  GlobalKey validateSignUpPage(formKey, ValidationChecker validationChecker) {
    FunctionResponse fResponse = getIt<FunctionResponse>();
    try {
      if (!formKey.currentState!.validate()) {
        validateSignUpForm(validationChecker, false);
      } else {
        validateSignUpForm(validationChecker, true);
        formKey.currentState!.save();
        formKey.currentState!.validate();
      }
    } catch (e) {
      fResponse.failed(message: 'error in signup validation : $e');
    }

    return formKey;
  }
}
