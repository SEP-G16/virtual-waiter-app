import '../model/menu_item.dart';

class MenuDataConstants{
  static final List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      name: 'Spring Rolls',
      description: 'Crispy spring rolls with a savory vegetable filling.',
      category: 'Appetizers',
      ingredients: ['Cabbage', 'Carrot', 'Onion', 'Garlic', 'Ginger'],
      price: 5.99,
      cuisine: 'Asian',
      tags: ['Vegan', 'Vegetarian'],
    ),
    MenuItem(
      id: '2',
      name: 'Grilled Chicken',
      description: 'Juicy grilled chicken with a side of vegetables.',
      category: 'Main Course',
      ingredients: ['Chicken', 'Bell Pepper', 'Onion', 'Garlic', 'Rosemary'],
      price: 12.99,
      cuisine: 'American',
      tags: ['Gluten-Free'],
    ),
    MenuItem(
      id: '3',
      name: 'Chocolate Cake',
      description:
      'Rich and moist chocolate cake topped with chocolate ganache.',
      category: 'Desserts',
      ingredients: ['Flour', 'Cocoa Powder', 'Sugar', 'Butter', 'Eggs'],
      price: 6.50,
      cuisine: 'French',
      tags: ['Vegetarian'],
    ),
    MenuItem(
      id: '4',
      name: 'Caesar Salad',
      description:
      'Classic Caesar salad with crispy romaine lettuce and croutons.',
      category: 'Entrees',
      ingredients: [
        'Romaine Lettuce',
        'Croutons',
        'Parmesan Cheese',
        'Caesar Dressing'
      ],
      price: 8.99,
      cuisine: 'Italian',
      tags: ['Vegetarian'],
    ),
    MenuItem(
      id: '5',
      name: 'Mango Smoothie',
      description: 'Refreshing mango smoothie with a hint of lime.',
      category: 'Beverages',
      ingredients: ['Mango', 'Yogurt', 'Honey', 'Lime'],
      price: 4.99,
      cuisine: 'Mexican',
      tags: ['Vegan', 'Gluten-Free'],
    ),
  ];
}
