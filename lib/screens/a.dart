// return SafeArea(
//         child: Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         children: [
//           createAppBar('Search'),
//           SizedBox(
//             height: 10,
//           ),
//           MyHomePage();
//         ],
//       ),
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Color.fromRGBO(10, 126, 0, 1), Colors.black],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               stops: [0.1, 0.6])),
//     ));


// Padding(
//         padding: const EdgeInsets.only(top: 10),
//         child: Row(
//           children: [
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   currentTabIndex = 0;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 width: 72,
//                 height: 25,
//                 decoration: ShapeDecoration(
//                   color: tabColor(0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   shadows: [
//                     BoxShadow(
//                       color: Color(0x3F000000),
//                       blurRadius: 5,
//                       offset: Offset(0, 4),
//                       spreadRadius: 0,
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Music',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontFamily: 'Harmattan',
//                       fontWeight: FontWeight.w500,
//                       height: 0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   currentTabIndex = 1;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 width: 70,
//                 height: 25,
//                 decoration: ShapeDecoration(
//                   color: tabColor(1),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   shadows: [
//                     BoxShadow(
//                       color: Color(0x3F000000),
//                       blurRadius: 5,
//                       offset: Offset(0, 4),
//                       spreadRadius: 0,
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Podcast',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontFamily: 'Harmattan',
//                       fontWeight: FontWeight.w500,
//                       height: 0,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 setState(() {
//                   currentTabIndex = 2;
//                 });
//               },
//               child: Container(
//                 margin: EdgeInsets.only(right: 10),
//                 width: 72,
//                 height: 25,
//                 decoration: ShapeDecoration(
//                   color: tabColor(2),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   shadows: [
//                     BoxShadow(
//                       color: Color(0x3F000000),
//                       blurRadius: 5,
//                       offset: Offset(0, 4),
//                       spreadRadius: 0,
//                     ),
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Radio',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontFamily: 'Harmattan',
//                       fontWeight: FontWeight.w500,
//                       height: 0,
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),