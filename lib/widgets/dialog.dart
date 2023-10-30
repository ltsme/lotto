import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future WillPopDialogWidget(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: const Text(
          "앱을 종료하시나요?",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      // true가 전달되어 앱이 종료 됨.
                      SystemNavigator.pop();
                    },
                    child: const Text("예")),
                TextButton(
                    onPressed: () {
                      // false가 전달되어 앱이 종료 되지 않음
                      Navigator.pop(context, false);
                    },
                    child: const Text("아니오")),
              ],
            ),
          ),
        ],
      );
    },
  );
}
