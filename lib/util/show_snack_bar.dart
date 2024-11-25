
import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showErrorSnackBar(BuildContext context,{required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      showCloseIcon: true,
      backgroundColor: Colors.red, // Optional: Customize the background color
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showWarningSnackBar(BuildContext context,{required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      showCloseIcon: true,
      backgroundColor: Colors.orange, // Optional: Customize the background color
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  static void showSuccessSnackBar(BuildContext context,{required String message}) {
    final snackBar = SnackBar(
      content: Text(message),
      showCloseIcon: true,
      backgroundColor: Colors.green, // Optional: Customize the background color
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}