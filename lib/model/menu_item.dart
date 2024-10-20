import 'package:virtual_waiter/model/category.dart';
import 'package:virtual_waiter/model/add_on.dart';

import '../enums/menu_item_status.dart';

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
  MenuItemStatus _status;

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
    this.imageUrl =
        'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
    this.addOns = const [],
    MenuItemStatus status = MenuItemStatus.InStock,
  }) : this._status = status;

  MenuItemStatus get status => _status;

  set status(MenuItemStatus status) => _status = status;

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
      imageUrl: map['imageUrl'] ??
          'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
      addOns: map['addOns'] != null
          ? List<AddOn>.from(map['addOns'].map((addOn) => AddOn.fromMap(addOn)))
          : [],
    );
  }

  MenuItem copyWith({
    int? id,
    String? name,
    String? shortDescription,
    String? longDescription,
    Category? category,
    List<String>? ingredients,
    double? price,
    String? cuisine,
    List<String>? tags,
    String? imageUrl,
    List<AddOn>? addOns,
    MenuItemStatus? status,
  }) {
    return MenuItem(
      id: id ?? this.id,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      longDescription: longDescription ?? this.longDescription,
      category: category ?? this.category,
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
      cuisine: cuisine ?? this.cuisine,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      addOns: addOns ?? this.addOns,
      status: status ?? this._status,
    );
  }
}
