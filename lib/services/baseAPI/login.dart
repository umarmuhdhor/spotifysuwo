import 'dart:convert';
import 'package:Suwotify/components/StorageKey.dart';
import 'package:Suwotify/components/config.dart';
import 'package:Suwotify/screens/app.dart';
import 'package:Suwotify/services/baseAPI/massageHandle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loginUser(BuildContext context, String email, String pass) async {
  final String apiUrl = "${Config.baseUrl}/auth/local";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "identifier": email,
        "password": pass,
      },
    );

    if (response.statusCode == 200) {
      print("Login Berhasil");
      final data = jsonDecode(response.body);
      final token = data['jwt'];
      print("Token dari Response: $token");
      prefs.setString(StorageKey.TOKEN, token);
      print(prefs.getString(StorageKey.TOKEN));
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (route) => false,
      );
    } else {
      print("Login Gagal: ${response.statusCode}");
      print("Pesan Kesalahan: ${response.body}");
      final responseData = jsonDecode(response.body);
      final errorMessage = responseData['error']['message'];
      showErrorAlert(context, errorMessage);
    }
  } catch (error) {
    print("Error: $error");
  }
}
