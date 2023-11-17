import 'package:Suwotify/services/baseAPI/song.dart';
import 'package:flutter/material.dart';
import 'package:Suwotify/services/categoryOperations.dart';
import 'package:Suwotify/models/category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  Widget createGrid() {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      child: GridView.count(
        childAspectRatio: 6 / 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: createListCategory(),
        crossAxisCount: 2,
        shrinkWrap: true,
      ),
    );
  }

  createListCategory() {
    List<Category> categoryList = CategoryOperations.getCategory();
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
  }

  Widget createCategory(Category category) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xA5D9D9D9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                category.image,
                fit: BoxFit.cover,
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                category.name,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Gotham Black',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [Color.fromRGBO(56, 27, 136, 1), Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.6],
          )),
          child: Column(
            children: [
              createGrid(),
              Container(
                margin: const EdgeInsets.only(top: 20, right: 10, left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text("Baru Diputar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.bold,
                            height: 0,
                          )),
                    ),
                    lastHeard()
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text("Recomendasi Untukmu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    Recommended(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text("Recomendasi Untukmu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    // Recommended(),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text("Recomendasi Untukmu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Gotham Black',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          )),
                    ),
                    // Recommended(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class lastHeard extends StatelessWidget {
  Future<dynamic> getDataMusic(String type) async {
    String fullUrl = '';
    try {
      http.Response? response = await getSong(type);
      if (response != null) {
        var savedData = json.decode(response.body);
        print('Saved Data: $savedData');
        return savedData;
      } else {
        print('Gagal mengambil data');
        return '';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  final List<String> images = [
    'images/Category1.jpg',
    'images/Category2.jpg',
    'images/Category3.jpg',
    'images/Category4.jpg',
    'images/Category5.jpg',
    'images/Category6.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    getDataMusic('audio8d');
    return CarouselSlider(
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 100,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        padEnds: false,
        height: 100,
        autoPlay: true,
        aspectRatio: 1.0,
        viewportFraction: 0.34,
      ),
    );
  }
}

class Recommended extends StatefulWidget {
  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  final List<String> images = [
    'images/Category1.jpg',
    'images/Category2.jpg',
    'images/Category3.jpg',
    'images/Category4.jpg',
    'images/Category5.jpg',
    'images/Category6.jpg',
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.width * 0.2;

    return CarouselSlider(
      items: images.asMap().entries.map((entry) {
        final index = entry.key;
        final image = entry.value;
        return Builder(
          builder: (BuildContext context) {
            return currentIndex == index
                ? Container(
                    height: imageHeight + 50,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Color(0x7FD9D9D9),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              image,
                              fit: BoxFit.fill,
                              height: imageHeight,
                            ),
                          ),
                        ),
                        Text("halo")
                      ],
                    ),
                  )
                : Container(
                    height: imageHeight,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        image,
                        fit: BoxFit.fill,
                        height: imageHeight,
                      ),
                    ),
                  );
          },
        );
      }).toList(),
      options: CarouselOptions(
        padEnds: false,
        autoPlay: true,
        height: imageHeight + 50,
        aspectRatio: 1.0,
        viewportFraction: 0.29,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
