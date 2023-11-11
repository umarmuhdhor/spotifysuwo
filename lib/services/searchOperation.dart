// import 'package:flutter/material.dart';

// class searchOperation extends SearchDelegate<String> {
//   final List<String> dummyData = [
//     'Apple',
//     'Banana',
//     'Cherry',
//     'Date',
//     'Grape',
//     'Lemon',
//   ];

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = dummyData.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(results[index]),
//           onTap: () {
           
//             Navigator.of(context).pop(results[index]);
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = dummyData.where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index]),
//           onTap: () {
//             query = suggestions[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
