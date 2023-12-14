import 'package:flutter/material.dart';
import 'package:Suwotify/screens/home.dart';
import 'package:Suwotify/screens/search.dart';
import 'package:Suwotify/screens/yourLibrary.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // ignore: non_constant_identifier_names
  final Tabs = [const Home(), const Search(), const YourLibrary()];
  int currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      // LoginPage()
      //  YourLibrary()
      Tabs[currentTabIndex],
      
      backgroundColor: Colors.transparent,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        onTap: (currentIndex) {
          currentTabIndex = currentIndex;
          setState(() {
            
          });
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
