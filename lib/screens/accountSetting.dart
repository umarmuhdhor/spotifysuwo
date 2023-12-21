import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AccountSettingsPage(),
    );
  }
}

class AccountSettingsPage extends StatefulWidget {
  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool _isNotificationEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isNotificationEnabled = prefs.getBool('notificationEnabled') ?? true;
    });
  }

  Future<void> _saveNotificationPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationEnabled', value);
  }

  void _navigateToEditProfile() {
    // Implementasikan logika navigasi ke halaman edit profil
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
  }

  void _navigateToChangePassword() {
    // Implementasikan logika navigasi ke halaman ubah kata sandi
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordPage()));
  }

  void _logout() {
    // Implementasikan logika logout sesuai kebutuhan
    // Misalnya, hapus token, bersihkan preferensi, dan navigasi ke halaman login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Edit Profile'),
            leading: Icon(Icons.edit),
            onTap: () {
              _navigateToEditProfile();
            },
          ),
          ListTile(
            title: Text('Change Password'),
            leading: Icon(Icons.lock),
            onTap: () {
              _navigateToChangePassword();
            },
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text('Notification Settings'),
              leading: Icon(Icons.notifications),
              trailing: Switch(
                value: _isNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationEnabled = value;
                    _saveNotificationPreference(value);
                  });
                },
              ),
            ),
          ),
          ListTile(
            title: Text('Log Out'),
            leading: Icon(Icons.exit_to_app),
            onTap: () {
              _logout();
            },
          ),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/default_avatar.jpg'), // Ganti dengan path gambar profil pengguna
            ),
            SizedBox(height: 20),
            Text('Name'),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            SizedBox(height: 20),
            Text('Email'),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simpan perubahan profil, misalnya, dengan mengirim data ke API
                // atau menyimpan ke penyimpanan lokal
                _saveProfileChanges();
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProfileChanges() {
    // Implementasikan logika untuk menyimpan perubahan profil
    String newName = _nameController.text;
    String newEmail = _emailController.text;

    // Lakukan sesuatu dengan data yang diubah, misalnya, kirim ke API atau simpan lokal

    // Tampilkan pesan konfirmasi perubahan
    _showConfirmationDialog();
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Updated'),
          content: Text('Your profile has been updated successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Current Password'),
            TextFormField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your current password',
              ),
            ),
            SizedBox(height: 20),
            Text('New Password'),
            TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter your new password',
              ),
            ),
            SizedBox(height: 20),
            Text('Confirm New Password'),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirm your new password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lakukan validasi dan simpan perubahan kata sandi
                _changePassword();
              },
              child: Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword() {
    // Implementasikan logika untuk mengganti kata sandi
    String currentPassword = _currentPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // Lakukan validasi, misalnya, pastikan kata sandi baru dan konfirmasi sesuai
    if (newPassword == confirmPassword) {
      // Lakukan perubahan kata sandi, misalnya, dengan mengirim data ke API
      // atau menyimpan ke penyimpanan lokal

      // Tampilkan pesan konfirmasi perubahan
      _showConfirmationDialog();
    } else {
      // Tampilkan pesan kesalahan jika kata sandi baru tidak sesuai dengan konfirmasi
      _showErrorDialog('Password Mismatch', 'New password and confirm password do not match.');
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Password Changed'),
          content: Text('Your password has been changed successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

