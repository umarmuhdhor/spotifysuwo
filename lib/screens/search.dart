import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

createAppBar(String message) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Padding(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontFamily: 'Gotham Black',
          fontWeight: FontWeight.w500,
          height: 0,
        ),
      ),
    ),
    actions: [
      Padding(
          padding: EdgeInsets.only(right: 10, top: 10), child: Icon(Icons.mic))
    ],
  );
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _searchController = TextEditingController();
  List<String> items = ["Apple", "Banana", "Cherry", "Date", "Grape", "Lemon"];
  List<String> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            createAppBar('Search'),
            Container(
              height: 40,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                cursorColor: Colors.white,
                cursorHeight: 20,
                controller: _searchController,
                onChanged: onSearchTextChanged,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                     
                  ),
                  contentPadding: EdgeInsets.only(left: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchResults[index]),
                  );
                },
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
    );
  }

  void onSearchTextChanged(String query) {
    query = query.toLowerCase();
    setState(() {
      searchResults =
          items.where((item) => item.toLowerCase().contains(query)).toList();
    });
  }
}
