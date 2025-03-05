import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:imagine_notes/core/navigation/go_router.dart';
import 'package:imagine_notes/core/theme/app_theme.dart';
import 'package:imagine_notes/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await dotenv.load(fileName: 'env');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ImagineNotesApp());
}

class ImagineNotesApp extends StatelessWidget {
  const ImagineNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Imagine Notes',
      theme: AppTheme.lightTheme,
      routerConfig: GoRouterHelper().router,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
    );
  }
}
