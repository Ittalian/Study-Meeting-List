import 'package:flutter/material.dart';
import 'package:study_meeting_list/model/dialog/loading_dialog.dart';

class BaseDialog extends StatelessWidget {
  final String title;
  final String message;
  final Function? trueFunction;
  final Function? falseFunction;
  const BaseDialog(
      {super.key,
      required this.title,
      required this.message,
      required this.trueFunction,
      required this.falseFunction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(message),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      LoadingDialog.show(context);
                      try {
                        await Future.delayed(const Duration(seconds: 3));
                        trueFunction!();
                      } finally {
                        await LoadingDialog.hide(context);
                        Navigator.pop(context);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 18,
                      ),
                      child: Text(
                        "はい",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 5,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      falseFunction!();
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 18,
                      ),
                      child: Text(
                        "いいえ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
