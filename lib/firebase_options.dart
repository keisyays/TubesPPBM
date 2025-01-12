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
    apiKey: 'AIzaSyAAsnd5kVIkn9eYoDU3Hn74GNNQ0yKhgug',
    appId: '1:977052530411:web:bea9c2b3aa4ae98ba130ae',
    messagingSenderId: '977052530411',
    projectId: 'tubesppbm',
    authDomain: 'tubesppbm.firebaseapp.com',
    storageBucket: 'tubesppbm.firebasestorage.app',
    measurementId: 'G-3F624BY8NE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4mdmjFmMHs7308Egb_ZxMvCT3BpBtTM4',
    appId: '1:977052530411:android:4d860db11148d111a130ae',
    messagingSenderId: '977052530411',
    projectId: 'tubesppbm',
    storageBucket: 'tubesppbm.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0O2uRQcvkPmJTtUcNLD9eiRGa70sz5ug',
    appId: '1:977052530411:ios:38342311281e8e7aa130ae',
    messagingSenderId: '977052530411',
    projectId: 'tubesppbm',
    storageBucket: 'tubesppbm.firebasestorage.app',
    iosBundleId: 'com.example.tubesppbm2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0O2uRQcvkPmJTtUcNLD9eiRGa70sz5ug',
    appId: '1:977052530411:ios:38342311281e8e7aa130ae',
    messagingSenderId: '977052530411',
    projectId: 'tubesppbm',
    storageBucket: 'tubesppbm.firebasestorage.app',
    iosBundleId: 'com.example.tubesppbm2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAAsnd5kVIkn9eYoDU3Hn74GNNQ0yKhgug',
    appId: '1:977052530411:web:adc93ecf5a5d2390a130ae',
    messagingSenderId: '977052530411',
    projectId: 'tubesppbm',
    authDomain: 'tubesppbm.firebaseapp.com',
    storageBucket: 'tubesppbm.firebasestorage.app',
    measurementId: 'G-B5E2CCJBCP',
  );
}