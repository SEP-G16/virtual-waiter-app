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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _initControllerData();
  }

  void _initControllerData() {
    _categoryItemMap = _mdnc.menuData;
    if (_categoryItemMap.entries.isEmpty) {
      throw Exception('Empty Menu in MenuDataController');
    }

    for (var entry in _categoryItemMap.entries) {
      String category = entry.key;
      List categoryItems = entry.value;

      if (categoryItems.isNotEmpty) {
        List<MenuItem> _items = categoryItems.map((item) {
          MenuItem menuItem = MenuItem.fromJson(item);
          _allItems.add(menuItem);
          return menuItem;
        }).toList();
        _items.sort((a, b) => a.name.compareTo(b.name));
        _menuItemOrderedMap[category] = _items;
      }
    }
  }
}
