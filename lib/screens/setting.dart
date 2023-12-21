import 'package:Suwotify/screens/accountSetting.dart';
import 'package:Suwotify/screens/notificationSetting.dart';
import 'package:Suwotify/screens/playbackSetting.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Account Settings'),
            onTap: () {
              // Navigasi ke layar pengaturan akun
              Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () {
              // Navigasi ke layar pengaturan notifikasi
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsPage()));
            },
          ),
          ListTile(
            title: Text('Playback Settings'),
            onTap: () {
              // Navigasi ke layar pengaturan pemutaran
              Navigator.push(context, MaterialPageRoute(builder: (context) => PlaybackSettingsPage()));
            },
          ),
          // Tambahkan opsi pengaturan lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
