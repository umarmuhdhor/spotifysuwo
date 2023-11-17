import 'dart:convert';
import 'package:Suwotify/models/category.dart';
import 'package:Suwotify/services/baseAPI/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class detailMusic extends StatefulWidget {
  const detailMusic({super.key});
  @override
  State<detailMusic> createState() => _detailMusicState();
}

class _detailMusicState extends State<detailMusic> {
  late Future<dynamic> _dataFuture;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _dataFuture = getDataMusic('audio8d');
    _audioPlayer = AudioPlayer();
  }

  Future<dynamic> getDataMusic(String type) async {
    try {
      http.Response? response = await getSong(type);
      if (response != null) {
        var savedData = json.decode(response.body);
        dynamic url = savedData['data'][0]['attributes'][type]['data']
            ['attributes']['url'];
        return 'http://localhost:1337$url';
      } else {
        print('Failed to fetch data/Gagal mengambil data');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  void playAudio(String url) {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      print('lagi diputar: $state');
      setState(() {
        isPlaying = state == PlayerState.playing;
        print(isPlaying);
      });
    });

    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(UrlSource(url));
    }
  }

  createAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
      elevation: 0.0,
      title: const Text('tes'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _dataFuture,
          builder: (context, Data) {
            if (Data.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (Data.hasError) {
              return Center(child: Text('Error: ${Data.error}'));
            } else if (!Data.hasData || Data.data == '') {
              return const Center(child: Text('No data available'));
            }

            String fullUrl = Data.data as String;

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromRGBO(56, 27, 136, 1), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.6],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        'images/Category1.jpg',
                        width: 320,
                        height: 320,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Text(
                    'StarBoy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Kaleb J',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 320,
                    margin: const EdgeInsets.only(right: 50, left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              AudioPlayer()
                                  .onPlayerStateChanged
                                  .listen((PlayerState state) {
                                print('lagi diputar: $state');
                              });
                              playAudio(fullUrl);
                            },
                            child: Icon(
                              isPlaying ? Icons.stop : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: const Text(
                            "Video Clip",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Gotham Black',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
