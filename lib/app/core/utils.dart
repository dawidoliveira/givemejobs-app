import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static void feedBack(
      {required bool isSuccess,
      required BuildContext context,
      required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          textColor: Colors.white,
          onPressed: () {},
          label: 'X',
        ),
      ),
    );
  }

  static bool sameRoute(BuildContext context, {required String toRoute}) {
    final newRouteName = toRoute;
    bool isNewRouteSameAsCurrent = false;

    Navigator.popUntil(context, (route) {
      if (route.settings.name == newRouteName) {
        isNewRouteSameAsCurrent = true;
      }
      return true;
    });

    return isNewRouteSameAsCurrent;
  }
}
