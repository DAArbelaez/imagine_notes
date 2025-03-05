import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final FirebaseOptions web = FirebaseOptions(
  apiKey: dotenv.env['WEBAPIKEY']!,
  appId: dotenv.env['WEBAPPID']!,
  messagingSenderId: dotenv.env['MESSAGINGSENDERID']!,
  projectId: dotenv.env['PROJECTID']!,
  authDomain: dotenv.env['AUTHDOMAIN']!,
  storageBucket: dotenv.env['STORAGEBUCKET']!,
  measurementId: dotenv.env['MEASUREMENTID']!,
);

final FirebaseOptions android = FirebaseOptions(
  apiKey: dotenv.env['ANDROIDAPIKEY']!,
  appId: dotenv.env['ANDROIDAPPID']!,
  messagingSenderId: dotenv.env['MESSAGINGSENDERID']!,
  projectId: dotenv.env['PROJECTID']!,
  storageBucket: dotenv.env['STORAGEBUCKET']!,
);
