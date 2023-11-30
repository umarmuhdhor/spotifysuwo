import 'dart:convert';

import 'package:Suwotify/components/StorageKey.dart';
import 'package:Suwotify/screens/app.dart';
import 'package:Suwotify/screens/favortieScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/baseAPI/user.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

Future<void> logoutUser(BuildContext context) async {
  
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(StorageKey.TOKEN, '');
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => MyApp()),
    (route) => false,
  );
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String email = '';
  List<dynamic> dataUser = [];
  bool loadingStatus = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loadingStatus = true;
    });
    try {
      http.Response? response =
          await getUser(prefs.getString(StorageKey.TOKEN) ?? "");

      final decodedData = json.decode(response!.body);

      setState(() {
        dataUser = Map.from(decodedData).values.toList();
        loadingStatus = false;
      });
      name = (dataUser[1]);
      print("name : $name");
      email = (dataUser[2]);
      print("email : $email");


    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
        title: const Text(
          "Profil",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(56, 27, 136, 1), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 16.0),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                email,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const Spacer(), 
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Favorite",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    logoutUser(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Container(
                    width: double.infinity, // Lebar tombol mengisi layar penuh
                    child: const Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
