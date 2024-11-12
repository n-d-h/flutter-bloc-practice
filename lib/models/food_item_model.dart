class MenuItem {
  final String category;
  final List<Item> items;

  MenuItem({required this.category, required this.items});
}

class Item {
  final String name;
  final String price;
  final String image;

  Item({required this.name, required this.price, required this.image});
}