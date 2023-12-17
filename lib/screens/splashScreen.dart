import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animation_set/flutter_animation_set.dart';
import 'package:Suwotify/screens/app.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityTween;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _opacityTween = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();

    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color.fromRGBO(56, 27, 136, 1)],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _opacityTween,
            builder: (context, child) {
              return Opacity(
                opacity: _opacityTween.value,
                child: FAWidget(
                  text: 'Selamat Datang!',
                  animationSet: 'bounceIn', // Gunakan efek bounceIn
                  duration: 1000,
                  delay: 0,
                  onFinish: () {
                    // Aksi setelah animasi selesai
                    print('Bounce In Animation Selesai');
                  },
                  onAnimation: (anim) {
                    // Mendengarkan animasi
                    print('Animasi: ${anim.animation} sedang berjalan');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
