import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loafer/core/helper/snackbar_helper.dart';
import 'package:loafer/core/model/user_model.dart';
import 'package:loafer/ui/homepage.dart';
import '../../core/preferences/preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> googleSignIn(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    final navigator = Navigator.of(context);
    setState(() {
      isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(authCredential);

      User? user = userCredential.user;
      if (user == null) return;
      UserModel userModel = UserModel(
        uid: user.uid,
        name: user.displayName ?? "",
        email: user.email ?? "",
        imageUrl: user.photoURL ?? "",
        isOnline: false,
        userColor: UserColor(
          isDarkMode: colorScheme.brightness == Brightness.dark,
          primary: colorScheme.primary.value,
          onPrimary: colorScheme.onPrimary.value,
          primaryContainer: colorScheme.primaryContainer.value,
          onPrimaryContainer: colorScheme.onPrimaryContainer.value,
        ),
      );

      Map<String, dynamic> userData = userModel.toJson();

      await Preferences.saveUser(userModel);
      if (userCredential.additionalUserInfo?.isNewUser == true) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set(userData);
      } else {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update(userData);
      }

      setState(() {
        isLoading = false;
      });

      navigator.pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          message: e.message,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue,
                  Colors.purple,
                ],
              ),
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Login to Continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                InkWell(
                  onTap: isLoading
                      ? null
                      : () {
                          googleSignIn(context);
                        },
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 238, 231, 231),
                    ),
                    child: isLoading
                        ? const CupertinoActivityIndicator()
                        : Row(
                            children: [
                              Image.asset("assets/icons/google.png"),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 6,
                              ),
                              const Text(
                                "Sign in With Google",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                  ),
                )
              ],
            ),
            // color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
