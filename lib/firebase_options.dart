import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return androidFirebaseOptions;
      case TargetPlatform.iOS:
        return iosFirebaseOptions;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return windowsFirebaseOptions;
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

  static final FirebaseOptions androidFirebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_ANDROID'] ?? '',
    appId: dotenv.env['FIREBASE_APP_ID_ANDROID'] ?? '',
    messagingSenderId: dotenv.env['FIREBASE_SENDER_ID_ANDROID'] ?? '',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_ANDROID'] ?? '',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_ANDROID'] ?? '',
  );

  static final FirebaseOptions iosFirebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_IOS'] ?? '',
    appId: dotenv.env['FIREBASE_APP_ID_IOS'] ?? '',
    messagingSenderId: dotenv.env['FIREBASE_SENDER_ID_IOS'] ?? '',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_IOS'] ?? '',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_IOS'] ?? '',
    iosBundleId: dotenv.env['FIREBASE_BUNDLE_ID_IOS'] ?? '',
  );

  static final FirebaseOptions windowsFirebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY_WINDOWS'] ?? '',
    appId: dotenv.env['FIREBASE_APP_ID_WINDOWS'] ?? '',
    messagingSenderId: dotenv.env['FIREBASE_SENDER_ID_WINDOWS'] ?? '',
    projectId: dotenv.env['FIREBASE_PROJECT_ID_WINDOWS'] ?? '',
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WINDOWS'] ?? '',
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WINDOWS'] ?? '',
    measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID_WINDOWS'] ?? '',
  );
}
