import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static Future navigateToScreen(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen, fullscreenDialog: false),
    );
  }

  static Future replaceScreen(BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen, fullscreenDialog: true),
    );
  }

  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }
}