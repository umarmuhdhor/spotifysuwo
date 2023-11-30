import 'package:http/http.dart' as http;
import 'package:Suwotify/components/config.dart';

Future<http.Response?> getPlaylist(
    String type1, String type2, String token) async {
  String apiUrl = '';
  apiUrl = '${Config.baseUrl}/playlists?populate[0]=$type1&populate[1]=$type2';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return response;
    } else {
      print('Gagal mengambil data audio: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // print('Error: $e');
    return null;
  }
}

Future<http.Response?> getSongPlaylist(int id, String token) async {
  String apiUrl = '';
  apiUrl = '${Config.baseUrl}/playlists/$id';

  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        // 'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      // print(response.body);
      return response;
    } else {
      print('Gagal mengambil data audio: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // print('Error: $e');
    return null;
  }
}
