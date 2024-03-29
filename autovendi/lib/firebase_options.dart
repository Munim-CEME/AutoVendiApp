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
    apiKey: 'AIzaSyCIAZClZuTdsBd4UfEqTP2rUZZ9HnOw6dE',
    appId: '1:631488551474:web:809d03eea9713264443a2b',
    messagingSenderId: '631488551474',
    projectId: 'autovendi-5d754',
    authDomain: 'autovendi-5d754.firebaseapp.com',
    databaseURL: 'https://autovendi-5d754-default-rtdb.firebaseio.com',
    storageBucket: 'autovendi-5d754.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBhjaJ5EWeZrSkUNSkYDwobkhi3t2J5gjs',
    appId: '1:631488551474:android:cd55078bc34e9f74443a2b',
    messagingSenderId: '631488551474',
    projectId: 'autovendi-5d754',
    databaseURL: 'https://autovendi-5d754-default-rtdb.firebaseio.com',
    storageBucket: 'autovendi-5d754.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCG9TLfQjlEQmr95KrX44iRzN3GB-dXLOI',
    appId: '1:631488551474:ios:14d1d7e001fd7048443a2b',
    messagingSenderId: '631488551474',
    projectId: 'autovendi-5d754',
    databaseURL: 'https://autovendi-5d754-default-rtdb.firebaseio.com',
    storageBucket: 'autovendi-5d754.appspot.com',
    iosBundleId: 'com.example.autovendi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCG9TLfQjlEQmr95KrX44iRzN3GB-dXLOI',
    appId: '1:631488551474:ios:ca652b4afa0b56b5443a2b',
    messagingSenderId: '631488551474',
    projectId: 'autovendi-5d754',
    databaseURL: 'https://autovendi-5d754-default-rtdb.firebaseio.com',
    storageBucket: 'autovendi-5d754.appspot.com',
    iosBundleId: 'com.example.autovendi.RunnerTests',
  );
}
