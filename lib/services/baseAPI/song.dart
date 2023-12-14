import 'package:http/http.dart' as http;
import 'package:Suwotify/components/config.dart';

Future<http.Response?> getAllSong(String type) async {
  String apiUrl = '';
  if (type == 'none') {
    apiUrl = '${Config.baseUrl}/songs';
  } else {
    apiUrl = '${Config.baseUrl}/songs?populate[0]=${type}';
  }
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  } catch (e) {
    // print('Error: $e');
    return null;
  }
}

Future<http.Response?> getSong(String type, int id) async {
  String apiUrl = '';
  apiUrl = '${Config.baseUrl}/songs/${id}?populate[0]=${type}';
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return response;
    } else {
      // print('Gagal mengambil data audio: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // print('Error: $e');
    return null;
  }
}


