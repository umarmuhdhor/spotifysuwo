// ignore_for_file: library_private_types_in_public_api

import 'package:Suwotify/screens/registerScreen.dart';
import 'package:Suwotify/services/baseAPI/login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  String? _errorTextPass;
  String? _errorTextEmail;
  bool _isLoading = false;

  bool showUsernameError = false;

  Future<void> LoginUser(
      BuildContext context, String email, String password) async {
    setState(() {
      _isLoading = true;
    });
    try {
      await loginUser(context, email, password);
    } catch (error) {
      print("Error during login: $error");
    } finally {
      setState(() {
        _isLoading = false;
      });
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
                      padding: const EdgeInsets.all(16.0),
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
                            child: const Text(
                              "Buat Akun?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration
                                    .underline, 
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
                    LoginUser(
                        context, emailController.text, passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        )
                      : const Text(
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
