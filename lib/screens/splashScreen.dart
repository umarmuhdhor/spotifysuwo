import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:Suwotify/screens/app.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Delay 2 detik sebelum memulai animasi
    _timer = Timer(
      const Duration(seconds: 7),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
        );
      },
    );
    playAudio('assets/1.mp3');

    // Delay animasi teks agar tidak berbarengan
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          // Set state or perform any other actions here

          // Memutar sound effect ketika animasi dimulai
        });
      }
    });
  }

  void playAudio(String url) {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      // Anda tidak perlu memeriksa isPlaying di sini
    });

    _audioPlayer.play(UrlSource(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color.fromRGBO(56, 27, 136, 1)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: BounceInUp(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/s_icon.svg',
                        width: 90,
                        color: const Color.fromRGBO(56, 27, 136, 1),
                        height: 90,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: BounceInRight(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/s_icon.svg',
                        width: 90,
                        color: const Color.fromRGBO(56, 27, 136, 1),
                        height: 90,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: BounceInLeft(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/s_icon.svg',
                        width: 90,
                        color: const Color.fromRGBO(56, 27, 136, 1),
                        height: 90,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: BounceInDown(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/s_icon.svg',
                        width: 90,
                        height: 90,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 2000)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Center(
                        child: Jello(
                          child: Center(
                            child: Container(
                              margin: const EdgeInsets.only(top: 7),
                              child: const Text(
                                "S",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(); // Placeholder or loading state
                    }
                  },
                ),
              ],
            ),
            FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 4000)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: SlideInUp(
                      child: const Center(
                        child: Text(
                          "Suwotify",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(height: 35,); // Placeholder or loading state
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
