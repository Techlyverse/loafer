import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/helper/firebase_helper.dart';
import '../core/helper/snackbar_helper.dart';
import '../core/model/user_model.dart';
import '../ui/welcome/onboarding.dart';

class UserProvider {
  Future<UserModel> getUserModel({
    required BuildContext context,
    required String uid,
  }) async {
    try {
      DocumentSnapshot snapshot = await FirebaseHelper.userDoc(uid).get();
      return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          message: e.message,
        );
      }
      rethrow;
    } catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context: context,
          message: e.toString(),
        );
      }
      rethrow;
    }
  }




}
Future<bool> logout(BuildContext context) async {
  final sharedPrefs = await SharedPreferences.getInstance();
  sharedPrefs.remove('uid');
  Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  return true;
}