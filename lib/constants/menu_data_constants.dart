import '../model/menu_item.dart';

class MenuDataConstants {
  static final List<MenuItem> menuItems = [
    MenuItem(
      id: '1',
      name: 'Spring Rolls',
      shortDescription: 'Crispy spring rolls with a savory vegetable filling.',
      longDescription: 'Delicious and crispy spring rolls filled with a mixture of cabbage, carrot, onion, garlic, and ginger. Perfect as an appetizer or snack.',
      category: 'Appetizers',
      ingredients: ['Cabbage', 'Carrot', 'Onion', 'Garlic', 'Ginger'],
      price: 5.99,
      cuisine: 'Asian',
      tags: ['Vegan', 'Vegetarian'],
      addOns: [
        {'id': 'a1', 'name': 'Extra Sauce', 'price': 0.50},
        {'id': 'a2', 'name': 'Extra Filling', 'price': 1.00},
      ],
    ),
    MenuItem(
      id: '2',
      name: 'Grilled Chicken',
      shortDescription: 'Juicy grilled chicken with a side of vegetables.',
      longDescription: 'Tender and juicy grilled chicken served with a side of sautéed bell pepper, onion, and garlic, seasoned with rosemary for a perfect main course.',
      category: 'Main Course',
      ingredients: ['Chicken', 'Bell Pepper', 'Onion', 'Garlic', 'Rosemary'],
      price: 12.99,
      cuisine: 'American',
      tags: ['Gluten-Free'],
      addOns: [
        {'id': 'b1', 'name': 'Extra Chicken', 'price': 3.00},
        {'id': 'b2', 'name': 'Side Salad', 'price': 2.50},
      ],
    ),
    MenuItem(
      id: '3',
      name: 'Chocolate Cake',
      shortDescription: 'Rich and moist chocolate cake topped with chocolate ganache.',
      longDescription: 'A decadent chocolate cake that is rich, moist, and topped with a silky chocolate ganache. Made with the finest cocoa powder and ingredients.',
      category: 'Desserts',
      ingredients: ['Flour', 'Cocoa Powder', 'Sugar', 'Butter', 'Eggs'],
      price: 6.50,
      cuisine: 'French',
      tags: ['Vegetarian'],
      addOns: [
        {'id': 'c1', 'name': 'Extra Ganache', 'price': 1.00},
        {'id': 'c2', 'name': 'Whipped Cream', 'price': 0.75},
      ],
    ),
    MenuItem(
      id: '4',
      name: 'Caesar Salad',
      shortDescription: 'Classic Caesar salad with crispy romaine lettuce and croutons.',
      longDescription: 'A classic Caesar salad made with fresh romaine lettuce, crunchy croutons, and grated Parmesan cheese, tossed in a creamy Caesar dressing.',
      category: 'Entrees',
      ingredients: ['Romaine Lettuce', 'Croutons', 'Parmesan Cheese', 'Caesar Dressing'],
      price: 8.99,
      cuisine: 'Italian',
      tags: ['Vegetarian'],
      addOns: [
        {'id': 'd1', 'name': 'Extra Dressing', 'price': 0.50},
        {'id': 'd2', 'name': 'Grilled Chicken', 'price': 2.50},
      ],
    ),
    MenuItem(
      id: '5',
      name: 'Mango Smoothie',
      shortDescription: 'Refreshing mango smoothie with a hint of lime.',
      longDescription: 'A refreshing smoothie made with ripe mangoes, creamy yogurt, a touch of honey, and a hint of lime. Perfect for a hot day.',
      category: 'Beverages',
      ingredients: ['Mango', 'Yogurt', 'Honey', 'Lime'],
      price: 4.99,
      cuisine: 'Mexican',
      tags: ['Vegan', 'Gluten-Free'],
      addOns: [
        {'id': 'e1', 'name': 'Protein Powder', 'price': 1.00},
        {'id': 'e2', 'name': 'Extra Mango', 'price': 1.50},
      ],
    ),
  ];
}
