import 'package:flutter/material.dart';
import 'base_dialog.dart';

class ConfirmDialog {
  final Function? trueFunction;
  final Function? falseFunction;
  const ConfirmDialog(
      {required this.trueFunction, required this.falseFunction});

  void showSave(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => BaseDialog(
          title: title,
          message: message,
          trueFunction: () {
            trueFunction!();
          },
          falseFunction: () {
            falseFunction!();
          }),
    );
  }
}
