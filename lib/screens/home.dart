import 'package:Suwotify/components/StorageKey.dart';
import 'package:Suwotify/screens/loginScreen.dart';
import 'package:Suwotify/screens/profileScreen.dart';
import 'package:flutter/material.dart';
import 'package:Suwotify/screens/podcast.dart';
import 'package:Suwotify/screens/music.dart';
import 'package:Suwotify/screens/radio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String token = '';
  // ignore: non_constant_identifier_names
  final Tab = [const Music(), const Podcast(), const RadioScreen()];
  int currentTabIndex = 0;

  Color tabColor(int index) {
    return index == currentTabIndex
        ? const Color(0xB2D9D9D9)
        : Colors.transparent;
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString(StorageKey.TOKEN) as String;
    });
  }

  createAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
      elevation: 0.0,
      actions: [
        token != ''
            ? Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: IconButton(
                  icon: const Icon(Icons.account_circle),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  },
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                ),
              ),
        const Padding(
          padding: EdgeInsets.only(right: 10, top: 10),
          child: Icon(Icons.history,),
        ),
        const Padding(
          padding: EdgeInsets.only(right: 10, top: 10),
          child: Icon(Icons.settings),
        ),
      ],
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
                margin: const EdgeInsets.only(right: 10),
                width: 64,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Center(
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
                margin: const EdgeInsets.only(right: 10),
                width: 64,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Center(
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
                margin: const EdgeInsets.only(right: 10),
                width: 64,
                height: 25,
                decoration: ShapeDecoration(
                  color: tabColor(2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Center(
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
