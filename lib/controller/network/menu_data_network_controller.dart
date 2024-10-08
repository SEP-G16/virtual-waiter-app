import 'package:get/get.dart';
import 'package:virtual_waiter/constants/menu_data_constants.dart';

import '../../model/menu_item.dart';

class MenuDataNetworkController extends GetxController {
  Map _menuData = {};
  Map get menuData => _menuData;

  final List<MenuItem> _menuItems = MenuDataConstants.menuItems;

  static MenuDataNetworkController instance = Get.find();

  MenuDataNetworkController._();

  static Future<MenuDataNetworkController> create() async {
    MenuDataNetworkController controller = MenuDataNetworkController._();
    await controller._getMenuData();
    return controller;
  }

  List _excludeJsonGeneratorByCategory(List<String> categories) {
    List<Map> filteredItems = [];
    for(String category in categories)
      {
        bool itemsExist = _menuItems.any((item) => item.category == category);
        if(itemsExist)
          {
            for (MenuItem item in _menuItems) {
              if(item.category == category)
                {
                  filteredItems.add(item.toJson());
                }
            }
          }
      }
    return filteredItems;
  }

  Future<void> _getMenuData() async {
    if (_menuData.keys.isEmpty) {
      await Future.delayed(Duration(milliseconds: 100));
      _menuData = {
        'Appetizers': _excludeJsonGeneratorByCategory(['Appetizers']),
        'Breakfast' : _excludeJsonGeneratorByCategory(['Breakfast']),
        'Salads & Soups': _excludeJsonGeneratorByCategory(['Salads', 'Soups']),
        'Main Course': _excludeJsonGeneratorByCategory(['Main Course']),
        'Desserts':_excludeJsonGeneratorByCategory(['Desserts']),
        'Beverages':_excludeJsonGeneratorByCategory(['Beverages']),
      };
    }
  }
}
