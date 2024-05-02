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
    apiKey: 'AIzaSyA9WZnlm6mgSpvACbJDVVDRoTb4B757_FA',
    appId: '1:41399715162:web:33487689aaadeeee161f63',
    messagingSenderId: '41399715162',
    projectId: 'tunitest-e022d',
    authDomain: 'tunitest-e022d.firebaseapp.com',
    storageBucket: 'tunitest-e022d.appspot.com',
    measurementId: 'G-Q0F89BZYTR',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBKb5y0HKOqygYuEsGpvF41BCksVUxqDi8',
    appId: '1:41399715162:ios:3572bebc37d8a55a161f63',
    messagingSenderId: '41399715162',
    projectId: 'tunitest-e022d',
    storageBucket: 'tunitest-e022d.appspot.com',
    iosBundleId: 'com.example.tuniWeb',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKb5y0HKOqygYuEsGpvF41BCksVUxqDi8',
    appId: '1:41399715162:ios:3572bebc37d8a55a161f63',
    messagingSenderId: '41399715162',
    projectId: 'tunitest-e022d',
    storageBucket: 'tunitest-e022d.appspot.com',
    iosBundleId: 'com.example.tuniWeb',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDXykFq1btawxYsaP6Bp2tXXSPkEN5GDLs',
    appId: '1:41399715162:android:7919ccd766e6c6cc161f63',
    messagingSenderId: '41399715162',
    projectId: 'tunitest-e022d',
    storageBucket: 'tunitest-e022d.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9WZnlm6mgSpvACbJDVVDRoTb4B757_FA',
    appId: '1:41399715162:web:21c0c77d7f23bd7b161f63',
    messagingSenderId: '41399715162',
    projectId: 'tunitest-e022d',
    authDomain: 'tunitest-e022d.firebaseapp.com',
    storageBucket: 'tunitest-e022d.appspot.com',
    measurementId: 'G-76RT20T0W4',
  );

}