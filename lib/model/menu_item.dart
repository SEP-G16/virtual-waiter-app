class MenuItem {
  String id;
  String name;
  String description;
  String category;
  List<String> ingredients;
  double price;
  String cuisine;
  List<String> tags;
  String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.ingredients,
    required this.price,
    required this.cuisine,
    required this.tags,
    this.imageUrl = 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg'
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'ingredients': ingredients,
      'price': price,
      'cuisine': cuisine,
      'tags': tags,
    };
  }

  factory MenuItem.fromJson(Map<String, dynamic> map) {
    return MenuItem(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      category: map['category'],
      ingredients: List<String>.from(map['ingredients']),
      price: map['price'],
      cuisine: map['cuisine'],
      tags: List<String>.from(map['tags']),
      imageUrl: map['imageUrl'] ?? 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
    );
  }
}
