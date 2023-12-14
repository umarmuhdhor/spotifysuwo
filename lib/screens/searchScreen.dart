import 'package:Suwotify/screens/detailMusic.dart';
import 'package:flutter/material.dart';
import '../services/baseAPI/song.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class MusicData {
  final int id;
  final String url;
  final String name;

  MusicData({
    required this.id,
    required this.url,
    required this.name,
  });
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> dataMusic = [];
  List<MusicData> _music = [];
  bool loadingStatus = false;

  TextEditingController _searchController = TextEditingController();
  List<MusicData> searchResults = [];

  Future<void> getAllMusic() async {
    setState(() {
      loadingStatus = true;
    });
    try {
      http.Response? response = await getAllSong('image');
      final decodedData = json.decode(response!.body);

      setState(() {
        dataMusic = Map.from(decodedData).values.toList();
        loadingStatus = false;
      });

      if (dataMusic != null) {
        for (int i = 0; i < dataMusic[0].length; i++) {
          int id = dataMusic[0][i]['id'];
          String url = (dataMusic[0][i]['attributes']['image']['data']
              ['attributes']['formats']['thumbnail']['url']);
          String name = (dataMusic[0][i]['attributes']['title']);
          _music.add(MusicData(
            id: id,
            url: url,
            name: name,
          ));
        }
      }

    } catch (error) {
      print(error.toString());
    }
  }

  void onSearchTextChanged(String query) {
    setState(() {
      searchResults = _music
          .where((result) =>
              result.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getAllMusic();
  }

  void navigateToDetailMusic(int musicId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => detailMusic(musicId: musicId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: TextField(
                  controller: _searchController,
                  onChanged: onSearchTextChanged,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    contentPadding: const EdgeInsets.only(left: 20),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          searchResults[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Image.network(
                          searchResults[index].url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          navigateToDetailMusic(searchResults[index].id);
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
