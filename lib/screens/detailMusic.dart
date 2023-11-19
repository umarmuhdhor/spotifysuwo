import 'dart:convert';
import 'package:Suwotify/models/category.dart';
import 'package:Suwotify/services/baseAPI/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class detailMusic extends StatefulWidget {
  final int musicId;
  const detailMusic({super.key, required this.musicId});
  @override
  State<detailMusic> createState() => _detailMusicState();
}

class MusicData {
  final String imageUrl;
  final String audioUrl;

  MusicData(this.imageUrl, this.audioUrl);
}

// ignore: camel_case_types
class _detailMusicState extends State<detailMusic> {
  late Future<MusicData> _dataFuture;
  late AudioPlayer _audioPlayer;
  late int musicId;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    musicId = widget.musicId;
    _dataFuture = getDataMusic(musicId);
  }

  Future<MusicData> getDataMusic(int id) async {
    try {
      http.Response? imageResponse = await getSong('image', id);
      http.Response? audioResponse = await getSong('audio', id);

      if (imageResponse != null && audioResponse != null) {
        var savedImageData = json.decode(imageResponse.body);
        // ignore: prefer_interpolation_to_compose_strings
        String imageUrl = 'http://localhost:1337' +
            savedImageData['data']['attributes']['image']['data']['attributes']
                ['url'];

        var savedAudioData = json.decode(audioResponse.body);
        String audioUrl = 'http://localhost:1337' +
            savedAudioData['data']['attributes']['audio']['data']['attributes']
                ['url'];

        return MusicData(imageUrl, audioUrl);
      } else {
        print('Failed to fetch data/Gagal mengambil data');
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error: $e');
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder<MusicData>(
          future: _dataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data?.imageUrl == '') {
              return const Center(child: Text('No data available'));
            }

            String imageUrl = snapshot.data!.imageUrl;
            String audioUrl = snapshot.data!.audioUrl;

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
                      child: Image.network(
                        imageUrl,
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
                              playAudio(audioUrl);
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
