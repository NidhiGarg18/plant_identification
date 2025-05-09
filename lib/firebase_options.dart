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
    apiKey: 'AIzaSyBeKrY929lh7yWFJJltwa78DwQVkLwdsRc',
    appId: '1:575746085058:web:0def3ed0736a793a17ab5b',
    messagingSenderId: '575746085058',
    projectId: 'plant-identification1',
    authDomain: 'plant-identification1.firebaseapp.com',
    storageBucket: 'plant-identification1.firebasestorage.app',
    measurementId: 'G-C1LYKM9QHX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB09tSwQBNLrRaXWl7SxQz0aOlaYVVGUqw',
    appId: '1:575746085058:android:90e12c5762405fb517ab5b',
    messagingSenderId: '575746085058',
    projectId: 'plant-identification1',
    storageBucket: 'plant-identification1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZzFPYKFK_eWAJtwKl4CKXKaYmTyqxKnU',
    appId: '1:575746085058:ios:f78f8074cc9f0e1217ab5b',
    messagingSenderId: '575746085058',
    projectId: 'plant-identification1',
    storageBucket: 'plant-identification1.firebasestorage.app',
    iosBundleId: 'com.example.plantIdentification',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZzFPYKFK_eWAJtwKl4CKXKaYmTyqxKnU',
    appId: '1:575746085058:ios:f78f8074cc9f0e1217ab5b',
    messagingSenderId: '575746085058',
    projectId: 'plant-identification1',
    storageBucket: 'plant-identification1.firebasestorage.app',
    iosBundleId: 'com.example.plantIdentification',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBeKrY929lh7yWFJJltwa78DwQVkLwdsRc',
    appId: '1:575746085058:web:4e6f72f6eb12633917ab5b',
    messagingSenderId: '575746085058',
    projectId: 'plant-identification1',
    authDomain: 'plant-identification1.firebaseapp.com',
    storageBucket: 'plant-identification1.firebasestorage.app',
    measurementId: 'G-4XQWZQPVXL',
  );

}