import 'package:flutter/material.dart';

class SnackBarHelper {
  const SnackBarHelper._();

  static void showErrorSnackBar({
    required BuildContext context,
    IconData? icon,
    String? message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon ?? Icons.warning_outlined),
            const SizedBox(width: 15),
            Text(message ?? "Oops an error occurred"),
          ],
        ),
      ),
    );
  }

  static void showSuccessSnackBar({
    required BuildContext context,
    IconData? icon,
    String? message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon ?? Icons.check_circle_outline),
            const SizedBox(width: 15),
            Text(message ?? "Success"),
          ],
        ),
      ),
    );
  }
}
