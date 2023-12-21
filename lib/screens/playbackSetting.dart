import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlaybackSettingsPage(),
    );
  }
}

class PlaybackSettingsPage extends StatefulWidget {
  @override
  _PlaybackSettingsPageState createState() => _PlaybackSettingsPageState();
}

class _PlaybackSettingsPageState extends State<PlaybackSettingsPage> {
  bool _isCrossfadeEnabled = true;
  bool _isAutoplayEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadPlaybackPreferences();
  }

  Future<void> _loadPlaybackPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isCrossfadeEnabled = prefs.getBool('crossfadeEnabled') ?? true;
      _isAutoplayEnabled = prefs.getBool('autoplayEnabled') ?? false;
    });
  }

  Future<void> _saveCrossfadePreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('crossfadeEnabled', value);
  }

  Future<void> _saveAutoplayPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('autoplayEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playback Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Crossfade'),
              subtitle: Text('Enable crossfade between songs.'),
              trailing: Switch(
                value: _isCrossfadeEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isCrossfadeEnabled = value;
                    _saveCrossfadePreference(value);
                  });
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Autoplay'),
              subtitle: Text(
                  'Automatically play similar songs when your music ends.'),
              trailing: Switch(
                value: _isAutoplayEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isAutoplayEnabled = value;
                    _saveAutoplayPreference(value);
                  });
                },
              ),
            ),
          ),
          // ... (tambahkan item preferensi pemutaran lainnya di sini)
        ],
      ),
    );
  }
}
