import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/model/user_model.dart';

class UiHelper{
  const UiHelper._();

  // get chat background and foreground color
  static (Color, Color) chatColor(BuildContext context, UserModel userModel) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool isDarkMode = colorScheme.brightness == Brightness.dark;
    final bool isMe = userModel.uid == FirebaseAuth.instance.currentUser?.uid;

    if (userModel.userColor?.primaryContainer != null) {
      if (userModel.userColor?.isDarkMode == true && isDarkMode) {
        return (
        Color(userModel.userColor!.primaryContainer!),
        Color(userModel.userColor!.onPrimaryContainer!),
        );
      } else if (userModel.userColor?.isDarkMode == false && !isDarkMode) {
        return (
        Color(userModel.userColor!.primaryContainer!),
        Color(userModel.userColor!.onPrimaryContainer!),
        );
      } else {
        return (
        Color(userModel.userColor!.onPrimaryContainer!),
        Color(userModel.userColor!.primaryContainer!),
        );
      }
    } else {
      if (isMe) {
        return (
        colorScheme.primaryContainer,
        colorScheme.onPrimaryContainer,
        );
      } else {
        return (
        colorScheme.surfaceVariant,
        colorScheme.onSurfaceVariant,
        );
      }
    }
  }
}
