import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  static flushBarMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          padding: EdgeInsets.all(8),
          message: message,
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 4),
          title: "ahfdayhg",
        )..show(context));
  }
}
