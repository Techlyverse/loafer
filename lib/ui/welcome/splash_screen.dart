import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loafer/core/model/user_model.dart';
import 'package:loafer/core/preferences/preferences.dart';
import 'package:loafer/providers/user_provider.dart';
import 'package:loafer/ui/homepage.dart';
import 'package:loafer/ui/welcome/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    final navigator = Navigator.of(context);
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        UserModel userModel = await UserProvider().getUserModel(
          context: context,
          uid: user.uid,
        );
        await Preferences.saveUser(userModel);
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      } else {
        navigator.pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return const Center(child: CupertinoActivityIndicator());
  }
}
