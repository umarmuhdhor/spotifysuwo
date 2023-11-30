import 'package:http/http.dart' as http;
import 'package:Suwotify/components/config.dart';

Future<http.Response?> getUser(String token) async {
  String apiUrl = '';
    apiUrl = '${Config.baseUrl}/users/me';
  
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token', 
      },
    );
    if (response.statusCode == 200) {
      return response;
    } else {
      print('Gagal mengambil data user: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    return null;
  }
}