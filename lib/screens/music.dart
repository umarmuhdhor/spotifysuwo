import 'package:flutter/material.dart';
import 'package:spotifyclone/services/categoryOperations.dart';
import 'package:spotifyclone/models/category.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Music extends StatelessWidget {
  const Music({Key? key}) : super(key: key);

  Widget createGrid() {
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5),
      child: GridView.count(
          childAspectRatio: 6 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: createListCategory(),
          crossAxisCount: 2,
          shrinkWrap: true),
    );
  }

  createListCategory() {
    List<Category> categoryList = CategoryOperations.getCategory();
    //Mengubah Data ke tipe widget
    List<Widget> categories = categoryList
        .map((Category category) => createCategory(category))
        .toList();
    return categories;
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
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(category.image, fit: BoxFit.cover)),
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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              createGrid(),
              Container(
                  margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                  child: lastHeard()),
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
                    Recommended(),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color.fromRGBO(10, 126, 0, 1), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.6])),
        ),
      ),
    );
  }
}

class lastHeard extends StatelessWidget {
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
    return CarouselSlider(
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: 100,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
    return Column(
      children: [
        CarouselSlider(
          items: images.asMap().entries.map((entry) {
            final index = entry.key;
            final image = entry.value;
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.grey
                        : null, // Warna latar belakang item yang dipilih
                  ),
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
            height: 100,
            autoPlay: true,
            aspectRatio: 1.0,
            viewportFraction: 0.29,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex =
                    index;
              });
            },
          ),
        ),
      ],
    );
  }
}
