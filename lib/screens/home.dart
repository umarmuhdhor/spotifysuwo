import 'package:flutter/material.dart';
import 'package:spotifyclone/models/category.dart';
import 'package:spotifyclone/models/type.dart';
import 'package:spotifyclone/services/categoryOperations.dart';
import 'package:spotifyclone/screens/music.dart';
import 'package:spotifyclone/screens/search.dart';
import 'package:spotifyclone/services/typeOperations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final a = [
    Music(),
    Search(),
  ];
  int currentTabIndex = 0;

  Widget createType(Type type) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xA5D9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(5.0), // Atur radius sesuai keinginan Anda
            child: Image.network(type.icon, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              type.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Gotham Black',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createCategory(Category category) {
    return Container(
      decoration: ShapeDecoration(
        color: Color(0xA5D9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(5.0), // Atur radius sesuai keinginan Anda
            child: Image.network(category.image, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                category.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Gotham Black',
                  fontWeight: FontWeight.w500,
                  height: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  createListType() {
    List<Type> typeList = TypeOperations.getType();
    //Mengubah Data ke tipe widget
    List<Widget> types = typeList.map((Type type) => createType(type)).toList();
    return types;
  }

  createListCategory() {
    List<Category> categoryList = CategoryOperations.getCategory();
    //Mengubah Data ke tipe widget
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createGrid() {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      height: 300,
      child: GridView.count(
        childAspectRatio: 7 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: createListCategory(),
        crossAxisCount: 2,
      ),
    );
  }

  createAppBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(10, 126, 0, 1),
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  currentTabIndex =
                      1; // Ganti indeks sesuai dengan halaman yang ingin ditampilkan
                });
              },
              child: Container(
                width: 72,
                height: 25,
                decoration: ShapeDecoration(
                  color: Color(0xB2D9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 5,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Music',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: 'Gotham Black',
                      fontWeight: FontWeight.w800,
                      height: 0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.history)),
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.settings))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: createAppBar(),
        body: a[currentTabIndex],
      ),
    );
  }
}
