import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NotificationSettingsPage(),
    );
  }
}

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool _isPushNotificationEnabled = true;
  bool _isEmailNotificationEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreferences();
  }

  Future<void> _loadNotificationPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isPushNotificationEnabled =
          prefs.getBool('pushNotificationEnabled') ?? true;
      _isEmailNotificationEnabled =
          prefs.getBool('emailNotificationEnabled') ?? false;
    });
  }

  Future<void> _savePushNotificationPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('pushNotificationEnabled', value);
  }

  Future<void> _saveEmailNotificationPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('emailNotificationEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Push Notifications'),
              subtitle: Text(
                  'Receive push notifications for updates and recommendations.'),
              trailing: Switch(
                value: _isPushNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isPushNotificationEnabled = value;
                    _savePushNotificationPreference(value);
                  });
                },
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Email Notifications'),
              subtitle:
                  Text('Receive emails for important updates and offers.'),
              trailing: Switch(
                value: _isEmailNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isEmailNotificationEnabled = value;
                    _saveEmailNotificationPreference(value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
