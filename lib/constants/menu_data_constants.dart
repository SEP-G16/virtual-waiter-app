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
      imageUrl: 'https://saltedmint.com/wp-content/uploads/2024/01/Vegetable-Spring-Rolls-3.jpg',
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
      imageUrl: 'https://www.lecremedelacrumb.com/wp-content/uploads/2022/11/best-easy-grilled-chicken-3.jpg',
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
      imageUrl: 'https://popmenucloud.com/cdn-cgi/image/width%3D1920%2Cheight%3D1920%2Cfit%3Dscale-down%2Cformat%3Dauto%2Cquality%3D60/ntkucixq/e859e805-4ad5-464c-9b6d-8466f2f29624.jpg',
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
      category: 'Salads',
      ingredients: ['Romaine Lettuce', 'Croutons', 'Parmesan Cheese', 'Caesar Dressing'],
      price: 8.99,
      cuisine: 'Italian',
      tags: ['Vegetarian'],
      imageUrl: 'https://cookieandkate.com/images/2021/05/caesar-salad-in-bowl-768x1157.jpg',
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
      imageUrl: 'https://lovingitvegan.com/wp-content/uploads/2016/10/Mango-Smoothie-2.jpg',
      addOns: [
        {'id': 'e1', 'name': 'Protein Powder', 'price': 1.00},
        {'id': 'e2', 'name': 'Extra Mango', 'price': 1.50},
      ],
    ),
    MenuItem(
      id: '6',
      name: 'Margherita Pizza',
      shortDescription: 'Classic Margherita pizza with fresh basil.',
      longDescription: 'A traditional Margherita pizza topped with fresh tomatoes, mozzarella cheese, and basil leaves, baked to perfection.',
      category: 'Main Course',
      ingredients: ['Tomatoes', 'Mozzarella', 'Basil', 'Olive Oil', 'Dough'],
      price: 10.99,
      cuisine: 'Italian',
      tags: ['Vegetarian'],
      imageUrl: 'https://foodbyjonister.com/wp-content/uploads/2020/01/MargheritaPizza.jpg',
      addOns: [
        {'id': 'f1', 'name': 'Extra Cheese', 'price': 1.50},
        {'id': 'f2', 'name': 'Olives', 'price': 0.75},
      ],
    ),
    MenuItem(
      id: '7',
      name: 'Beef Tacos',
      shortDescription: 'Tasty beef tacos with fresh salsa.',
      longDescription: 'Spicy and flavorful beef tacos served with fresh salsa, lettuce, and cheese in a soft tortilla.',
      category: 'Main Course',
      ingredients: ['Beef', 'Tortilla', 'Lettuce', 'Cheese', 'Salsa'],
      price: 9.99,
      cuisine: 'Mexican',
      tags: ['Spicy'],
      imageUrl: 'https://www.courtneyssweets.com/wp-content/uploads/2022/02/ground-beef-tacos-10.jpg',
      addOns: [
        {'id': 'g1', 'name': 'Extra Salsa', 'price': 0.50},
        {'id': 'g2', 'name': 'Sour Cream', 'price': 0.75},
      ],
    ),
    MenuItem(
      id: '8',
      name: 'Sushi Platter',
      shortDescription: 'Assorted sushi platter with fresh fish.',
      longDescription: 'A variety of sushi including nigiri, sashimi, and rolls, made with the freshest fish and ingredients.',
      category: 'Main Course',
      ingredients: ['Rice', 'Fish', 'Seaweed', 'Vegetables', 'Soy Sauce'],
      price: 18.99,
      cuisine: 'Japanese',
      tags: ['Seafood'],
      imageUrl: 'https://i.redd.it/84obefjhqt6b1.jpg',
      addOns: [
        {'id': 'h1', 'name': 'Extra Wasabi', 'price': 0.50},
        {'id': 'h2', 'name': 'Ginger', 'price': 0.25},
      ],
    ),
    MenuItem(
      id: '9',
      name: 'Vegetable Stir Fry',
      shortDescription: 'Colorful vegetable stir fry with a savory sauce.',
      longDescription: 'A mix of colorful vegetables stir-fried in a savory sauce, served over a bed of rice. A healthy and delicious option.',
      category: 'Main Course',
      ingredients: ['Broccoli', 'Bell Pepper', 'Carrot', 'Soy Sauce', 'Garlic'],
      price: 7.99,
      cuisine: 'Asian',
      tags: ['Vegan', 'Vegetarian'],
      imageUrl: 'https://natashaskitchen.com/wp-content/uploads/2020/08/Vegetable-Stir-Fry-2.jpg',
      addOns: [
        {'id': 'i1', 'name': 'Extra Sauce', 'price': 0.50},
        {'id': 'i2', 'name': 'Tofu', 'price': 1.50},
      ],
    ),
    MenuItem(
      id: '10',
      name: 'Berry Parfait',
      shortDescription: 'Layers of fresh berries and creamy yogurt.',
      longDescription: 'A delicious parfait made with layers of fresh berries, creamy yogurt, and a touch of honey. Perfect for breakfast or a light dessert.',
      category: 'Desserts',
      ingredients: ['Berries', 'Yogurt', 'Honey', 'Granola'],
      price: 5.50,
      cuisine: 'American',
      tags: ['Vegetarian', 'Gluten-Free'],
      imageUrl: 'https://sweetlysplendid.com/wp-content/uploads/2020/09/breakfast-berry-parfait-2.jpg',
      addOns: [
        {'id': 'j1', 'name': 'Extra Granola', 'price': 0.75},
        {'id': 'j2', 'name': 'Chia Seeds', 'price': 0.50},
      ],
    ),
    MenuItem(
      id: '11',
      name: 'Greek Salad',
      shortDescription: 'Fresh Greek salad with feta cheese and olives.',
      longDescription: 'A refreshing Greek salad made with cucumbers, tomatoes, olives, red onions, and feta cheese, tossed in a light vinaigrette.',
      category: 'Salads',
      ingredients: ['Cucumber', 'Tomato', 'Olives', 'Feta Cheese', 'Onion'],
      price: 8.50,
      cuisine: 'Greek',
      tags: ['Vegetarian', 'Gluten-Free'],
      imageUrl: 'https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2018/08/Greek-Salad-6-1.jpg',
      addOns: [
        {'id': 'k1', 'name': 'Extra Feta', 'price': 1.00},
        {'id': 'k2', 'name': 'Pita Bread', 'price': 1.50},
      ],
    ),
    MenuItem(
      id: '12',
      name: 'Pasta Carbonara',
      shortDescription: 'Creamy pasta carbonara with pancetta.',
      longDescription: 'Classic pasta carbonara made with a creamy sauce, pancetta, and Parmesan cheese. A comforting and delicious meal.',
      category: 'Main Course',
      ingredients: ['Pasta', 'Pancetta', 'Egg', 'Parmesan', 'Cream'],
      price: 11.99,
      cuisine: 'Italian',
      tags: ['Rich'],
      imageUrl: 'https://leitesculinaria.com/wp-content/uploads/2024/04/spaghetti-carbonara-1200.jpg',
      addOns: [
        {'id': 'l1', 'name': 'Extra Cheese', 'price': 1.50},
        {'id': 'l2', 'name': 'Garlic Bread', 'price': 2.00},
      ],
    ),
    MenuItem(
      id: '13',
      name: 'Lemon Tart',
      shortDescription: 'Tangy lemon tart with a buttery crust.',
      longDescription: 'A tangy and sweet lemon tart with a buttery crust. Perfect for dessert or a special treat.',
      category: 'Desserts',
      ingredients: ['Lemon', 'Sugar', 'Butter', 'Flour', 'Eggs'],
      price: 4.99,
      cuisine: 'French',
      tags: ['Vegetarian'],
      imageUrl: 'https://media-cldnry.s-nbcnews.com/image/upload/newscms/2023_51/2043794/matt-adlard-lemon-tart-1x1-zz-231220.jpg',
      addOns: [
        {'id': 'm1', 'name': 'Whipped Cream', 'price': 0.75},
        {'id': 'm2', 'name': 'Berries', 'price': 1.50},
      ],
    ),
    MenuItem(
      id: '14',
      name: 'Avocado Toast',
      shortDescription: 'Creamy avocado toast with a sprinkle of chili flakes.',
      longDescription: 'A healthy and delicious avocado toast topped with a sprinkle of chili flakes and a drizzle of olive oil. Perfect for breakfast or brunch.',
      category: 'Breakfast',
      ingredients: ['Avocado', 'Bread', 'Chili Flakes', 'Olive Oil', 'Salt'],
      price: 6.50,
      cuisine: 'American',
      tags: ['Vegan', 'Vegetarian'],
      imageUrl: 'https://www.dontgobaconmyheart.co.uk/wp-content/uploads/2022/03/avocado-cream-cheese-toast.jpg',
      addOns: [
        {'id': 'n1', 'name': 'Poached Egg', 'price': 1.50},
        {'id': 'n2', 'name': 'Tomato', 'price': 0.75},
      ],
    ),
    MenuItem(
      id: '15',
      name: 'Tom Yum Soup',
      shortDescription: 'Spicy and sour Tom Yum soup with shrimp.',
      longDescription: 'A traditional Thai soup that is spicy, sour, and packed with flavors from lemongrass, kaffir lime leaves, and shrimp.',
      category: 'Soups',
      ingredients: ['Shrimp', 'Lemongrass', 'Kaffir Lime Leaves', 'Mushrooms', 'Chili'],
      price: 7.99,
      cuisine: 'Thai',
      tags: ['Spicy', 'Seafood'],
      imageUrl: 'https://thewoksoflife.com/wp-content/uploads/2021/10/Tom-Yum-Soup-11.jpg',
      addOns: [
        {'id': 'o1', 'name': 'Extra Shrimp', 'price': 2.00},
        {'id': 'o2', 'name': 'Rice', 'price': 1.50},
      ],
    ),
  ];
}
