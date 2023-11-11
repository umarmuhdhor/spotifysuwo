import 'package:flutter/material.dart';

class RadioScreen extends StatelessWidget {
  const RadioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      'Radio',
      style: TextStyle(fontSize: 40, color: Colors.yellow),
    ));
  }
}
