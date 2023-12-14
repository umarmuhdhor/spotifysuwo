import 'package:flutter/material.dart';
import 'package:Suwotify/screens/searchScreen.dart';
import 'package:Suwotify/services/categoryOperations.dart';
import 'package:Suwotify/models/category.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  Widget createGrid() {
    return Container(
      margin: const EdgeInsets.only(right: 5, left: 5),
      child: GridView.count(
        childAspectRatio: 6 / 2,
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
      decoration: const BoxDecoration(
        color: Color(0xA5D9D9D9),
      ),
      child: Row(
        children: [
          ClipRRect(
              child: Image.asset(category.image, fit: BoxFit.cover)),
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

  createAppBar(String message) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Gotham Black',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 10, top: 10),
            child: Icon(Icons.mic))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          createAppBar('Search'),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.transparent),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.white, width: 1.0),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const Icon(
                      Icons.search, 
                      color: Colors.white, 
                      size: 24.0, 
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: const Text('Seacrh'),
                  ),
                ],
              ),
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
            margin: const EdgeInsets.only(top: 30, right: 10, left: 10),
            child: createGrid(),
          )
        ],
      ),
    ));
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
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colors.grey
                        : null, 
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
                currentIndex = index;
              });
            },
          ),
        ),
      ],
    );
  }
}
