// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCvkWPRFR3n7LTG2xhNZNoxJLxDClrkfTM',
    appId: '1:1084785624364:web:60aed5f847ae3b94e49889',
    messagingSenderId: '1084785624364',
    projectId: 'moc-tp-firebase-flutter',
    authDomain: 'moc-tp-firebase-flutter.firebaseapp.com',
    storageBucket: 'moc-tp-firebase-flutter.appspot.com',
    measurementId: 'G-L2WEJVGN1V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7zvDJk7Q7lX36UWZtfUYn5yRpDjELR_s',
    appId: '1:1084785624364:android:9a9474667c78d712e49889',
    messagingSenderId: '1084785624364',
    projectId: 'moc-tp-firebase-flutter',
    storageBucket: 'moc-tp-firebase-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDn4VXuik5qjJM60tKuosq2ZhSuVZpaL2g',
    appId: '1:1084785624364:ios:f4e6f266bf426bb0e49889',
    messagingSenderId: '1084785624364',
    projectId: 'moc-tp-firebase-flutter',
    storageBucket: 'moc-tp-firebase-flutter.appspot.com',
    iosBundleId: 'com.example.tpFirebaseFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDn4VXuik5qjJM60tKuosq2ZhSuVZpaL2g',
    appId: '1:1084785624364:ios:f4e6f266bf426bb0e49889',
    messagingSenderId: '1084785624364',
    projectId: 'moc-tp-firebase-flutter',
    storageBucket: 'moc-tp-firebase-flutter.appspot.com',
    iosBundleId: 'com.example.tpFirebaseFlutter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCvkWPRFR3n7LTG2xhNZNoxJLxDClrkfTM',
    appId: '1:1084785624364:web:7fa6e484b9b1d7cce49889',
    messagingSenderId: '1084785624364',
    projectId: 'moc-tp-firebase-flutter',
    authDomain: 'moc-tp-firebase-flutter.firebaseapp.com',
    storageBucket: 'moc-tp-firebase-flutter.appspot.com',
    measurementId: 'G-XFMD27RBY6',
  );
}
