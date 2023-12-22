import 'dart:convert';
import 'package:Suwotify/services/baseAPI/song.dart';
import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DetailMusic extends StatefulWidget {
  final int musicId;

  const DetailMusic({Key? key, required this.musicId}) : super(key: key);

  @override
  State<DetailMusic> createState() => _DetailMusicState();
}

final Logger _logger = Logger();

class MusicData {
  final String imageUrl;
  final String audioUrl;
  final String title;
  final String artist;

  MusicData(this.imageUrl, this.audioUrl, this.title, this.artist);
}

class _DetailMusicState extends State<DetailMusic> {
  late Future<MusicData> _dataFuture;
  late audio.AudioPlayer _audioPlayer;
  late int musicId;
  bool isPlaying = false;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _audioPlayer = audio.AudioPlayer();
    musicId = widget.musicId;
    _dataFuture = getDataMusic(musicId);
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'k4TbAUAp3KU',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  Future<MusicData> getDataMusic(int id) async {
    try {
      http.Response? imageResponse = await getSong('image', id);
      http.Response? audioResponse = await getSong('audio', id);
      http.Response? artistResponse = await getSong('artist', id);

      if (imageResponse != null &&
          audioResponse != null &&
          artistResponse != null) {
        var savedImageData = json.decode(imageResponse.body);
        String imageUrl = savedImageData['data']['attributes']['image']['data']
            ['attributes']['url'];

        var savedArtistData = json.decode(artistResponse.body);
        String artistName = savedArtistData['data']['attributes']['artist']
            ['data']['attributes']['name'];

        String title = savedImageData['data']['attributes']['title'];

        var savedAudioData = json.decode(audioResponse.body);
        String audioUrl = savedAudioData['data']['attributes']['audio']['data']
            ['attributes']['url'];

        return MusicData(imageUrl, audioUrl, title, artistName);
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void playAudio(String url) {
    _audioPlayer.onPlayerStateChanged.listen((audio.PlayerState state) {
      setState(() {
        isPlaying = state == audio.PlayerState.playing;
      });
    });

    if (isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play(audio.UrlSource(url));
    }

    _youtubeController.pause();
  }

  createAppBar() {
    return AppBar(
      backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
      elevation: 0.0,
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite),
          onPressed: () {},
        ),
      ],
      iconTheme: const IconThemeData(color: Colors.white),
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
            String title = snapshot.data!.title;
            String artist = snapshot.data!.artist;

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
                    margin: const EdgeInsets.only(top: 20),
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
                  const SizedBox(height: 20),
                  
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left, 
                  ),
                  const SizedBox(height: 2),
                  Text(
                    artist,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left, 
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
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.transparent,
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              _audioPlayer.onPlayerStateChanged
                                  .listen((audio.PlayerState state) {
                                _logger.i('lagi diputar: $state');
                              });
                              playAudio(audioUrl);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
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
                            Icons.skip_next,
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
                  YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      _logger.i('Video is ready.');
                    },
                    onEnded: (data) {
                      _logger.i('Video has ended.');
                    },
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
