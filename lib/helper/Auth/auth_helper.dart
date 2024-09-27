import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:coraapp/models/Auth/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/constants.dart';
import 'check_credentials.dart';

class AuthHelper {
  Future<Map> loginWithGoogle() async {
    FirebaseExeptionHandler firebaseExeptionHandler = FirebaseExeptionHandler();
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        Get.snackbar('', 'Please select a google account to proceed');
        log('Please select a google account to proceed');
        return Future.error('Please select a google account to proceed');
      } else {
        GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;
        OAuthCredential? credential = await GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        final UserCredential authResult =
            await UserAuth.auth.signInWithCredential(credential);
        UserAuth.user = authResult.user;
        assert(await UserAuth.user?.getIdToken() != null);
        final User? thisUser = UserAuth.auth.currentUser;
        assert(UserAuth.user?.uid == thisUser?.uid);
        final map = {
          'email': UserAuth.user?.email ?? '',
          'name': UserAuth.user?.displayName ?? '',
          'profile_image': UserAuth.user?.photoURL ?? '',
          'phone': UserAuth.user?.phoneNumber ?? '',
          'google_id': UserAuth.user?.uid ?? '',
          "user_type": 'user',
        };
        await GoogleSignIn().signOut();
        // signOut from firebase
        await UserAuth.auth.signOut();
        return map;
      }
    } on FirebaseException catch (e) {
      final error = firebaseExeptionHandler.getMessageFromErrorCode(e.code);
      Get.snackbar('', error);
      log('Error occured while signing in with google in FirebaseException: $error $e');
      return Future.error(error);
    } on AssertionError catch (e, s) {
      Get.snackbar('', 'Error occured while signing in with google');
      log('Error occured while signing in with google in AssertionError: $e');
      return Future.error(e.toString());
    } catch (e) {
      Get.snackbar('', 'Error occured while signing in with google');
      log('Error occured while signing in with google in Catch: $e');
      return Future.error(e.toString());
    }
  }

  Future<Map> loginWithFacebook() async {
    FirebaseExeptionHandler firebaseExeptionHandler = FirebaseExeptionHandler();
    try {
      final status = await Permission.appTrackingTransparency.request();
      if (status == PermissionStatus.granted) {
        await FacebookAuth.i.autoLogAppEventsEnabled(true);
      }
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile', 'user_birthday'],
        loginBehavior: LoginBehavior.dialogOnly,
      );
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        final UserCredential authResult =
            await UserAuth.auth.signInWithCredential(facebookAuthCredential);
        UserAuth.user = authResult.user;
        assert(await UserAuth.user?.getIdToken() != null);
        final User? thisUser = UserAuth.auth.currentUser;
        assert(UserAuth.user?.uid == thisUser?.uid);
        final map = {
          'email': UserAuth.user?.email,
          'name': UserAuth.user?.displayName,
          'profile_image': UserAuth.user?.photoURL,
          'phone': UserAuth.user?.phoneNumber,
          'facebook_id': UserAuth.user?.uid,
        };
        await FacebookAuth.instance.logOut();
        await UserAuth.auth.signOut();
        return map;
      } else {
        Get.snackbar('', 'Please select a facebook account to proceed');
        log('Please select a facebook account to proceed');
        return Future.error('Please select a facebook account to proceed');
      }
    } on FirebaseException catch (e) {
      final error = firebaseExeptionHandler.getMessageFromErrorCode(e.code);
      Get.snackbar('', error);
      log('Error occured while signing in with facebook in FirebaseException: $error $e');
      return Future.error(error);
    } on AssertionError catch (e, s) {
      Get.snackbar('', 'Error occured while signing in with facebook');
      log('Error occured while signing in with facebook in AssertionError: $e');
      return Future.error(e.toString());
    } catch (e) {
      Get.snackbar('', 'Error occured while signing in with facebook');
      log('Error occured while signing in with facebook in Catch: $e');
      return Future.error(e.toString());
    }
  }

  Future<Map> loginWithApple() async {
    FirebaseExeptionHandler firebaseExeptionHandler = FirebaseExeptionHandler();
    try {
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credentialApple = oAuthProvider.credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
        rawNonce: rawNonce,
      );
      final authResult =
          await UserAuth.auth.signInWithCredential(credentialApple);
      UserAuth.user = authResult.user;
      assert(await UserAuth.user?.getIdToken() != null);
      final User? thisUser = UserAuth.auth.currentUser;
      assert(UserAuth.user?.uid == thisUser?.uid);
      final map = {
        'email': UserAuth.user?.email,
        'name': UserAuth.user?.displayName,
        'profile_image': UserAuth.user?.photoURL,
        'phone': UserAuth.user?.phoneNumber,
        'apple_id': UserAuth.user?.uid,
      };
      await UserAuth.auth.signOut();
      return map;
    } on SignInWithAppleException catch (e, s) {
      Get.snackbar('', 'Error occured while signing in with apple $e');
      log('Error occured while signing in with apple in SignInWithAppleException: $e');
      return Future.error(e.toString());
    } on FirebaseException catch (e) {
      final error = firebaseExeptionHandler.getMessageFromErrorCode(e.code);
      Get.snackbar('', error + ' $e');
      log('Error occured while signing in with apple in FirebaseException: $error $e');
      return Future.error(error);
    } on AssertionError catch (e, s) {
      Get.snackbar('', 'Error occured while signing in with apple');
      log('Error occured while signing in with apple in AssertionError: $e');
      return Future.error(e.toString());
    } catch (e) {
      Get.snackbar('', 'Error occured while signing in with apple');
      log('Error occured while signing in with apple in Catch: $e');
      return Future.error(e.toString());
    }
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
