import 'package:flutter/material.dart';

class SnackBarService{

 static void showSnackBar(String str,BuildContext context) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        elevation: 9.0,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        duration: const Duration(seconds: 10),
        content: Container(
          height: 50.0,
          alignment: Alignment.center,
          child: Text(
            str,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}