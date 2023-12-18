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
              // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsScreen()));
            },
          ),
          ListTile(
            title: Text('Notification Settings'),
            onTap: () {
              // Navigasi ke layar pengaturan notifikasi
              // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationSettingsScreen()));
            },
          ),
          ListTile(
            title: Text('Playback Settings'),
            onTap: () {
              // Navigasi ke layar pengaturan pemutaran
              // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => PlaybackSettingsScreen()));
            },
          ),
          // Tambahkan opsi pengaturan lainnya sesuai kebutuhan
        ],
      ),
    );
  }
}
