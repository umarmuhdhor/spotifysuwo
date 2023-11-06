import 'package:flutter/material.dart';
import 'package:spotifyclone/models/type.dart';
import 'package:spotifyclone/screens/podcast.dart';
import 'package:spotifyclone/screens/music.dart';
import 'package:spotifyclone/screens/radio.dart';
import 'package:spotifyclone/services/typeOperations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final Tab = [Music(), Podcast(), RadioScreen()];
  int currentTabIndex = 0;

  Color tabColor(int index) {
    return index == currentTabIndex ? Color(0xB2D9D9D9) : Colors.transparent;
  }

  Widget createType(Type type) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xA5D9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(type.icon, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              type.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Harmattan',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  createListType() {
    List<Type> typeList = TypeOperations.getType();
    //Mengubah Data ke tipe widget
    List<Widget> types = typeList.map((Type type) => createType(type)).toList();
    return types;
  }

  createAppBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(10, 126, 0, 1),
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentTabIndex = 0;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 72,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Harmattan',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentTabIndex = 1;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 70,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Podcast',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Harmattan',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  currentTabIndex = 2;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                width: 72,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Radio',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Harmattan',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.history)),
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: createAppBar(),
        body: Tab[currentTabIndex],
      ),
    );
  }
}
