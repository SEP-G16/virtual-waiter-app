import 'package:get/get.dart';
import 'package:virtual_waiter/controller/network/menu_data_network_controller.dart';

import '../../model/menu_item.dart';

class MenuDataController extends GetxController {
  Map _categoryItemMap = {};
  Map<String, List<MenuItem>> _menuItemOrderedMap = {};
  Map<String, List<MenuItem>> get menuItemOrderedMap => _menuItemOrderedMap;

  List<MenuItem> _allItems = [];
  List<MenuItem> get allItems => _allItems;

  final MenuDataNetworkController _mdnc = MenuDataNetworkController.instance;
  static MenuDataController instance = Get.find();

  MenuDataController._();

  static Future<MenuDataController> create() async {
    MenuDataController controller = MenuDataController._();
    await controller._initControllerData();
    return controller;
  }


  Future<void> _initControllerData() async {
    await _getMenuData();
  }

  Future<void> _getMenuData() async {
    List<Map<String, dynamic>> menuData = await _mdnc.getMenuData();
    _categoryItemMap = {};
    _allItems = [];
    for (var item in menuData) {
      MenuItem menuItem = MenuItem.fromMap(item);
      _allItems.add(menuItem);
      if (_categoryItemMap.containsKey(menuItem.category.name)) {
        _categoryItemMap[menuItem.category.name].add(menuItem.toMap());
      } else {
        _categoryItemMap[menuItem.category.name] = [menuItem.toMap()];
      }
    }

    for (var entry in _categoryItemMap.entries) {
      String category = entry.key;
      List categoryItems = entry.value;

      if (categoryItems.isNotEmpty) {
        List<MenuItem> _items = categoryItems.map((item) {
          MenuItem menuItem = MenuItem.fromMap(item);
          _allItems.add(menuItem);
          return menuItem;
        }).toList();
        _items.sort((a, b) => a.name.compareTo(b.name));
        _menuItemOrderedMap[category] = _items;
      }
    }
  }

  MenuItem findItemById({required int id}) {
    if(_allItems.any((item) => item.id == id)){
      return _allItems.where((item) => item.id == id).toList().first;
    }
    else
      {
        throw Exception('Item Not Found');
      }
  }


}
