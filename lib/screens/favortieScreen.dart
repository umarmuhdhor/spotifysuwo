import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
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

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<MusicData> _favoriteMusic =[]; 

  void navigateToDetailMusic(int musicId) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 27, 136, 1),
        elevation: 0,
        title: const Text(
          "Favorite Music",
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
                  itemCount: _favoriteMusic.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          _favoriteMusic[index].name,
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Image.network(
                          _favoriteMusic[index].url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        onTap: () {
                          navigateToDetailMusic(_favoriteMusic[index].id);
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
