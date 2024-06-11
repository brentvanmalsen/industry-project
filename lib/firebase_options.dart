// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

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
        return windows;
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
    apiKey: 'AIzaSyCNoRELHPURzMAF7Klz6qq4CLqW-OkvXGQ',
    appId: '1:886866201063:android:58d30f02c28604902cd542',
    messagingSenderId: '886866201063',
    projectId: 'industry-project-krom',
    storageBucket: 'industry-project-krom.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCL2rhjRixnDqsxtGRY1bppXl3Ux2-N4OQ',
    appId: '1:886866201063:ios:eb12da06a8b0963c2cd542',
    messagingSenderId: '886866201063',
    projectId: 'industry-project-krom',
    storageBucket: 'industry-project-krom.appspot.com',
    iosBundleId: 'com.example.industryProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDaNrMPnaiQ1Q5aM7Gwgbbrz2q0DoCaobU',
    appId: '1:886866201063:web:e72f9e702e9690dc2cd542',
    messagingSenderId: '886866201063',
    projectId: 'industry-project-krom',
    authDomain: 'industry-project-krom.firebaseapp.com',
    storageBucket: 'industry-project-krom.appspot.com',
    measurementId: 'G-0KHNQWQCCE',
  );
}