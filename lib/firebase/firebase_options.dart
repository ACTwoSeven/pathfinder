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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCI1tBVV1Lodfk6T-eM-wkPdIX3_WQTcaw',
    appId: '1:636132875980:web:939589090afdf463976c69',
    messagingSenderId: '636132875980',
    projectId: 'pathfinder-203d0',
    authDomain: 'pathfinder-203d0.firebaseapp.com',
    databaseURL: 'https://pathfinder-203d0-default-rtdb.firebaseio.com/',
    storageBucket: 'pathfinder-203d0.appspot.com',
    measurementId: 'G-DRV1L2GXSH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3DbQqmi1O-QBXUboa-j5sa3Ci7mbprAA',
    appId: '1:636132875980:android:90877c609f441821976c69',
    messagingSenderId: '636132875980',
    projectId: 'pathfinder-203d0',
    storageBucket: 'pathfinder-203d0.appspot.com',
    databaseURL: 'https://pathfinder-203d0-default-rtdb.firebaseio.com/',
  );
}
