import 'package:flutter/material.dart';

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      'Music',
      style: TextStyle(fontSize: 40, color: Colors.yellow),
    ));
  }
}

// return Scaffold(
//       body: Container(
//         padding: EdgeInsets.all(10),
//         child: Column(
//           children: [
//             createAppBar('Good Morning'),
//             SizedBox(
//               height: 10,
//             ),
//             createGrid()
//           ],
//         ),
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [Color.fromRGBO(10, 126, 0, 1), Colors.black],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.1, 0.6])),
//       ),
//     );
