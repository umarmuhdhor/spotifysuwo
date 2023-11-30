import 'package:flutter/material.dart';

void showErrorAlert(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Login Failed',
          style: TextStyle(
            color: Colors.red, 
          ),
        ),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: const Text(
              'Okay',
              style: TextStyle(
                color: Colors.blue, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: Colors.white, 
        elevation: 100,
      );
    },
  );
}
