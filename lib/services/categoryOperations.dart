import 'package:spotifyclone/models/category.dart';

class CategoryOperations {
  CategoryOperations._() {}
  static List<Category> getCategory() {
    return <Category>[
      Category('Top Hits Indonesia', 'images/Category1.jpg'),
      Category('Top Dance Hits 2023', 'images/Category2.jpg'),
      Category("80'S Best Songs", 'images/Category3.jpg'),
      Category('Summer Vibes 2023', 'images/Category4.jpg'),
      Category('Remix Song 2023', 'images/Category5.jpg'),
      Category("90'S Best Songs", 'images/Category6.jpg'),
    ];
  }
}
