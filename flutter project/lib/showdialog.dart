

import 'package:first_flutter_app/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showMyDialog {
  static void show(BuildContext context, String result, String? remind) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'THÔNG BÁO',
              style: TextStyle(
                  color: Colors.blue
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(result),
                if(result == Constants.CALL_FAIL) Text(remind!),
              ],
            ),
          );
        }
    );
  }
}