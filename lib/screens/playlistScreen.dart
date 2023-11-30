import 'dart:convert';
import 'package:Suwotify/screens/playlistScreen.dart';
import 'package:Suwotify/services/baseAPI/song.dart';
import 'package:Suwotify/services/baseAPI/user.dart';
import 'package:http/http.dart' as http;
import 'package:Suwotify/components/StorageKey.dart';
import 'package:Suwotify/screens/library/libraryMusic.dart';
import 'package:Suwotify/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Suwotify/services/baseAPI/playlist.dart';

class PlaylistScreen extends StatefulWidget {
  final int id;
  const PlaylistScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class PlaylistMusicData {
  final int id;
  final String url;
  final String name;

  PlaylistMusicData({
    required this.id,
    required this.url,
    required this.name,
  });
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  List<dynamic> dataPlaylist = [];
  List<dynamic> dataPlaySong = [];
  List<PlaylistMusicData> _playlistMusic = [];
  bool loadingStatus = false;

  void navigateToDetailMusic(int musicId) {}

  Future<void> getAllPlaylist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loadingStatus = true;
    });
    try {
      http.Response? response = await getSongPlaylist(
          widget.id, prefs.getString(StorageKey.TOKEN) ?? "");

      final decodedData = json.decode(response!.body);

      setState(() {
        dataPlaylist = Map.from(decodedData).values.toList();
        loadingStatus = false;
      });

      if (dataPlaylist != null) {
        for (int i = 0; i < dataPlaylist[0].length; i++) {
          print(dataPlaylist[0]);
          int id = (dataPlaylist[0][i]['attributes']['songs']['data']['id']);
          print(id);

          http.Response? response2 = await getSong('image', id);
          final decodedData = json.decode(response2!.body);

          setState(() {
            dataPlaySong = Map.from(decodedData).values.toList();
          });

          if (dataPlaySong != null) {
            int id = (dataPlaySong[0][i]['id']);
            String name = (dataPlaySong[0][i]['attributes']['title']);
            String url = (dataPlaySong[0][i]['attributes']['title']);
            // String deskripsi = (dataPlaylist[0][i]['attributes']['deskripsi']);
            // int user =
            //     (dataPlaylist[0][i]['attributes']['users']['data']['id']);
            // _playlistMusic.add(
            //   PlaylistMusicData(
            //     id: id,
            //     url: "http://localhost:1337$url",
            //     name: name,
            //   ),
            // );
          }
        }
      }
    } catch (error) {
      print(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
        elevation: 0,
        title: const Text(
          "Playlist",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
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
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: _playlistMusic.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          _playlistMusic[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Image.network(
                          _playlistMusic[index].url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          navigateToDetailMusic(_playlistMusic[index].id);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}