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
    apiKey: 'AIzaSyAX2e1logesyWTmXV7-cJdZZyI0ins5k4E',
    appId: '1:63119306280:web:b6fded2df6e868e9a04f1d',
    messagingSenderId: '63119306280',
    projectId: 'chatapp-d8a0c',
    authDomain: 'chatapp-d8a0c.firebaseapp.com',
    storageBucket: 'chatapp-d8a0c.appspot.com',
    measurementId: 'G-1GXX0R7VZJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyARYByLPRMjQHqh4TTj1mk-Q9bTsVdgFAA',
    appId: '1:63119306280:android:37fc755cf9bd944ba04f1d',
    messagingSenderId: '63119306280',
    projectId: 'chatapp-d8a0c',
    storageBucket: 'chatapp-d8a0c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDq9m8UpvivdHEhsmcUqn3Bcg6kgj35vp4',
    appId: '1:63119306280:ios:f9bbf9a735da13dfa04f1d',
    messagingSenderId: '63119306280',
    projectId: 'chatapp-d8a0c',
    storageBucket: 'chatapp-d8a0c.appspot.com',
    androidClientId: '63119306280-20mgv6gi51vdmmtsuovmpsu8qtpihiso.apps.googleusercontent.com',
    iosClientId: '63119306280-okem8oo4ttgkh2tofl877d69v34rlt5q.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}