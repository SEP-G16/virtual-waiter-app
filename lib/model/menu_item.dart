class MenuItem {
  String id;
  String name;
  String shortDescription;
  String longDescription;
  String category;
  List<String> ingredients;
  double price;
  String cuisine;
  List<String> tags;
  String imageUrl;
  List<Map<String, dynamic>> addOns;

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'category': category,
      'ingredients': ingredients,
      'price': price,
      'cuisine': cuisine,
      'tags': tags,
      'imageUrl': imageUrl,
      'addOns': addOns,
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      shortDescription: map['shortDescription'],
      longDescription: map['longDescription'],
      category: map['category'],
      ingredients: List<String>.from(map['ingredients']),
      price: map['price'],
      cuisine: map['cuisine'],
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'] ?? 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
      addOns: List<Map<String, dynamic>>.from(map['addOns'] ?? []),
    );
  }
}
