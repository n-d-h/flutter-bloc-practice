import 'dart:math';

import 'package:bloc_learner/models/food_item_model.dart';

class MenuRepositories {
  static List<MenuItem> fetchMenu() {
    return List.generate(5, (index) {
      return MenuItem(
        category: 'Cate ${index + 1} ${index % 2 == 0 ? "silver" : ""}',
        items: List.generate(Random().nextInt(5) + 5, (itemIndex) {
          return Item(
            name: 'Item $itemIndex',
            price: Random().nextInt(100).toString(),
            image: 'assets/images/app-logo.png',
          );
        }),
      );
    });
  }
}
