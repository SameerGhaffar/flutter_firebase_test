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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBbsBPZAZKFikP4O0FGEWeN2VOpuECdLQY',
    appId: '1:345528985077:web:41576a28c258d8a6456cbc',
    messagingSenderId: '345528985077',
    projectId: 'flutter-firebase-test-59b85',
    authDomain: 'flutter-firebase-test-59b85.firebaseapp.com',
    storageBucket: 'flutter-firebase-test-59b85.appspot.com',
    measurementId: 'G-BL5D6Y6P9F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBt5FW25ALEOCX6WX-5OiQn0n4ujbJzcr0',
    appId: '1:345528985077:android:b5ae0bc40cf2d15e456cbc',
    messagingSenderId: '345528985077',
    projectId: 'flutter-firebase-test-59b85',
    storageBucket: 'flutter-firebase-test-59b85.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6oKAid4WXLF-s-Xr_U7yrRqgL84mb8Qk',
    appId: '1:345528985077:ios:38d03006066271c7456cbc',
    messagingSenderId: '345528985077',
    projectId: 'flutter-firebase-test-59b85',
    storageBucket: 'flutter-firebase-test-59b85.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6oKAid4WXLF-s-Xr_U7yrRqgL84mb8Qk',
    appId: '1:345528985077:ios:2efef1f23f39f3f9456cbc',
    messagingSenderId: '345528985077',
    projectId: 'flutter-firebase-test-59b85',
    storageBucket: 'flutter-firebase-test-59b85.appspot.com',
    iosBundleId: 'com.example.flutterFirebaseTest.RunnerTests',
  );
}
