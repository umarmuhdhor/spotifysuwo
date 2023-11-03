import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Gotham Black',
            fontWeight: FontWeight.w800,
            height: 0,
          ),
        ),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.mic))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          createAppBar('Setting'),
          SizedBox(
            height: 10,
          ),
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(10, 126, 0, 1), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.6])),
    ));
  }
}
