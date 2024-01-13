import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loafer/core/preferences/preferences.dart';
import 'package:loafer/core/services/firebase_appcheck.dart';
import 'package:loafer/core/services/firebase_crashlytics.dart';
import 'package:loafer/core/theme/dark_theme.dart';
import 'package:loafer/core/theme/light_theme.dart';
import 'package:loafer/firebase_options.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:loafer/ui/welcome/splash_screen.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //initCrashlytics();
  // await initAppCheck();
  await Preferences.initPreferences();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightScheme, darkScheme) {
      return MaterialApp(
        theme: lightTheme(lightScheme),
        darkTheme: darkTheme(darkScheme),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      );
    });
  }
}
