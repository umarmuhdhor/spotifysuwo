// import 'package:http/http.dart' as http;

// void fetchData() async {
//   var url = Uri.parse("https://spotify23.p.rapidapi.com/search/?q=%3CREQUIRED%3E&type=multi&offset=0&limit=10&numberOfTopResults=5");

//   var headers = {
//     "X-RapidAPI-Key": "88fe399b14msha693ffcf1cf5fb7p19badfjsnfe86e025f888",
//     "X-RapidAPI-Host": "spotify23.p.rapidapi.com",
//   };

//   var response = await http.get(url, headers: headers);

//   if (response.statusCode == 200) {
//     // Tangani respons yang berhasil di sini
//     print("Respons: ${response.body}");
//   } else {
//     // Tangani kesalahan
//     print("Error: ${response.statusCode}");
//   }
// }

// void main() {
//   fetchData();
// }