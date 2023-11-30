import 'dart:convert';
import 'package:Suwotify/components/StorageKey.dart';
import 'package:Suwotify/screens/app.dart';
import 'package:Suwotify/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../services/baseAPI/massageHandle.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  String? _errorTextPass;
  String? _errorTextEmail;

  bool showUsernameError = false;

  Future<void> loginUser() async {
    final String apiUrl = "http://localhost:1337/api/auth/local";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          "identifier": emailController.text,
          "password": passwordController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
        elevation: 0.0,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Color.fromRGBO(56, 27, 136, 1), Colors.black],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.1, 0.6],
        )),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextField(
                      controller: emailController,
                      focusNode: usernameFocusNode,
                      decoration: InputDecoration(
                        errorText: _errorTextEmail,
                        labelText: "Username/Email",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          emailController.text.isEmpty
                              ? _errorTextEmail = 'Input cannot be empty'
                              : _errorTextEmail = null;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: _errorTextPass,
                        labelText: "Password",
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          passwordController.text.isEmpty
                              ? _errorTextPass = 'Input cannot be empty'
                              : _errorTextPass = null;
                        });
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Lupa Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text(
                              "Buat Akun?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration
                                    .underline, // Menambahkan garis bawah pada teks
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                width: MediaQuery.of(context).size.width - 90,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    loginUser();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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
