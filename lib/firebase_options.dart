// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDawRsjCp1UYPdbsLAK-rFXM0V0pu2nqxo',
    appId: '1:1040101222371:web:5b319d5021212c8f0fa2d6',
    messagingSenderId: '1040101222371',
    projectId: 'mywebapp-140fd',
    authDomain: 'mywebapp-140fd.firebaseapp.com',
    storageBucket: 'mywebapp-140fd.appspot.com',
    measurementId: 'G-32TTVZEJVR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBh7EqwjyZvlb8AFuvJIYdte6Vzx7cRZT4',
    appId: '1:1040101222371:android:4958f07e87d746af0fa2d6',
    messagingSenderId: '1040101222371',
    projectId: 'mywebapp-140fd',
    storageBucket: 'mywebapp-140fd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk-Bz18kT99tDQ96a9mJSsBhMit4BmUzU',
    appId: '1:1040101222371:ios:46f580aedaa8fb380fa2d6',
    messagingSenderId: '1040101222371',
    projectId: 'mywebapp-140fd',
    storageBucket: 'mywebapp-140fd.appspot.com',
    iosClientId: '1040101222371-ijhkfpjpves59bnh9dcdn5jo40lc4cb4.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}