// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7iG_ZECHsjznPsC6KAFE0nvXxNbj8ko4',
    appId: '1:553552936314:android:f874544bfc6fcaa1242ac3',
    messagingSenderId: '553552936314',
    projectId: 'cora-ca727',
    storageBucket: 'cora-ca727.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA8EyhJAxEOuTCFz2nVw1551ESkFeKvAjc',
    appId: '1:553552936314:ios:23a1c2542518cd12242ac3',
    messagingSenderId: '553552936314',
    projectId: 'cora-ca727',
    storageBucket: 'cora-ca727.appspot.com',
    androidClientId: '553552936314-mlilof7q0lklaq6282qhggfqrfvec88v.apps.googleusercontent.com',
    iosClientId: '553552936314-f0sdgpdl8kfij72j4qrdj6so9j2dl4g0.apps.googleusercontent.com',
    iosBundleId: 'com.cora.user',
  );
}
