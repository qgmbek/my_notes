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
    apiKey: 'AIzaSyCOTLlmOGvjAQiG3fCC_b7wzioobDbQ1Rc',
    appId: '1:247912665015:web:329ad744f39397d04e6232',
    messagingSenderId: '247912665015',
    projectId: 'notes-flutter-course-lll',
    authDomain: 'notes-flutter-course-lll.firebaseapp.com',
    storageBucket: 'notes-flutter-course-lll.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKr66jdwrcfHe0QNAKvKA2l0DTSRCBqWE',
    appId: '1:247912665015:android:5ba8486e174808c64e6232',
    messagingSenderId: '247912665015',
    projectId: 'notes-flutter-course-lll',
    storageBucket: 'notes-flutter-course-lll.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-HpPbkyDIWmg7ibbDy6HcJ0pG780kJ78',
    appId: '1:247912665015:ios:a3e46b98b909ec464e6232',
    messagingSenderId: '247912665015',
    projectId: 'notes-flutter-course-lll',
    storageBucket: 'notes-flutter-course-lll.appspot.com',
    iosBundleId: 'com.example.myNotes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC-HpPbkyDIWmg7ibbDy6HcJ0pG780kJ78',
    appId: '1:247912665015:ios:f1a79294472ee98e4e6232',
    messagingSenderId: '247912665015',
    projectId: 'notes-flutter-course-lll',
    storageBucket: 'notes-flutter-course-lll.appspot.com',
    iosBundleId: 'com.example.myNotes.RunnerTests',
  );
}
