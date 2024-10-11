import 'package:virtual_waiter/model/category.dart';
import 'package:virtual_waiter/model/add_on.dart';

class MenuItem {
  int id;
  String name;
  String shortDescription;
  String longDescription;
  Category category;
  List<String> ingredients;
  double price;
  String cuisine;
  List<String> tags;
  String imageUrl;
  List<AddOn> addOns;

  MenuItem({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.longDescription,
    required this.category,
    required this.ingredients,
    required this.price,
    required this.cuisine,
    required this.tags,
    this.imageUrl = 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
    this.addOns = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'category': category.toMap(),
      'ingredients': ingredients,
      'price': price,
      'cuisine': cuisine,
      'tags': tags,
      'imageUrl': imageUrl,
      'addOns': addOns.map((addOn) => addOn.toMap()).toList(),
    };
  }

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      shortDescription: map['shortDescription'],
      longDescription: map['longDescription'],
      category: Category.fromMap(map['category']),
      ingredients: List<String>.from(map['ingredients']),
      price: map['price'],
      cuisine: map['cuisine'],
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'] ?? 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
      addOns: map['addOns'] != null ? List<AddOn>.from(map['addOns'].map((addOn) => AddOn.fromMap(addOn))) : [],
    );
  }
}
