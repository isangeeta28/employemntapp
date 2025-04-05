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
    apiKey: 'AIzaSyCnKRuML9EM8G1JyuV-JhrE8mF7qLFxy6o',
    appId: '1:2407787256:web:9d43e2186053ec1474e90d',
    messagingSenderId: '2407787256',
    projectId: 'employmentapp-7ce90',
    authDomain: 'employmentapp-7ce90.firebaseapp.com',
    storageBucket: 'employmentapp-7ce90.firebasestorage.app',
    measurementId: 'G-D91RB2WWJC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIc_pVqF5h_S2XrpXnG7ygGkhhk2IjNKo',
    appId: '1:2407787256:android:aa539457e710065b74e90d',
    messagingSenderId: '2407787256',
    projectId: 'employmentapp-7ce90',
    storageBucket: 'employmentapp-7ce90.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8IjyctLTA8pCxATYaEK3t24MbFEo-Qs8',
    appId: '1:2407787256:ios:3c056d5c0ed7ae4874e90d',
    messagingSenderId: '2407787256',
    projectId: 'employmentapp-7ce90',
    storageBucket: 'employmentapp-7ce90.firebasestorage.app',
    iosBundleId: 'com.example.employmentapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD8IjyctLTA8pCxATYaEK3t24MbFEo-Qs8',
    appId: '1:2407787256:ios:3c056d5c0ed7ae4874e90d',
    messagingSenderId: '2407787256',
    projectId: 'employmentapp-7ce90',
    storageBucket: 'employmentapp-7ce90.firebasestorage.app',
    iosBundleId: 'com.example.employmentapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnKRuML9EM8G1JyuV-JhrE8mF7qLFxy6o',
    appId: '1:2407787256:web:3462079f49742e2f74e90d',
    messagingSenderId: '2407787256',
    projectId: 'employmentapp-7ce90',
    authDomain: 'employmentapp-7ce90.firebaseapp.com',
    storageBucket: 'employmentapp-7ce90.firebasestorage.app',
    measurementId: 'G-R9CPPM6CBL',
  );

}