import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // Widget createGrid() {
  //   return GridView.count()
  // }

  createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(message),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 10), child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Column(
        children: [
          createAppBar('Good Morning'),
          SizedBox(
            height: 5,
          )
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromARGB(255, 9, 195, 25), Colors.black],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.5])),
    ));
  }
}
