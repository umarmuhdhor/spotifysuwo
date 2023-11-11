import 'package:flutter/material.dart';

class Podcast extends StatelessWidget {
  const Podcast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      'Podcast',
      style: TextStyle(fontSize: 40, color: Colors.yellow),
    ));
  }
}
