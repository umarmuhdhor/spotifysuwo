import 'package:Suwotify/models/category.dart';
import 'package:Suwotify/screens/detailMusic.dart';
import 'package:Suwotify/services/categoryOperations.dart';
import 'package:flutter/material.dart';
import 'package:Suwotify/screens/home.dart';
import 'package:Suwotify/screens/search.dart';
import 'package:Suwotify/screens/yourLibrary.dart';
import './../services/baseAPI/song.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Tabs = [Home(), Search(), YourLibrary()];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Tabs[currentTabIndex],
      
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (currentIndex) {
          currentTabIndex = currentIndex;
          setState(() {});
        },
        selectedLabelStyle: const TextStyle(color: Colors.white),
        selectedItemColor: Colors.white,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books, color: Colors.white),
              label: 'library')
        ],
      ),
    );
  }
}
