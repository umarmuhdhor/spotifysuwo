import 'package:Suwotify/models/category.dart';

class CategoryOperations {
  static List<Category> getCategory() {
    return <Category>[
      Category(
        'Top Hits Indonesia',
        'images/Category1.jpg',
        songIds : [1,2,3]
      ),
      Category(
        'Top Dance Hits 2023',
        'images/Category2.jpg',
        songIds : [3,4,5],
      ),
      Category(
        "80'S Best Songs",
        'images/Category3.jpg',
        songIds : [1,2,3],
      ),
      Category(
        'Summer Vibes 2023',
        'images/Category4.jpg',
        songIds : [1,2,3],
      ),
      Category(
        'Remix Song 2023',
        'images/Category5.jpg',
        songIds : [1,2,3],
      ),
      Category(
        "90'S Best Songs",
        'images/Category6.jpg',
        songIds : [1,2,3],
      ),
    ];
  }
}
