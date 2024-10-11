import 'package:get/get.dart';
import 'package:virtual_waiter/constants/menu_data_constants.dart';

import '../../model/menu_item.dart';

class MenuDataNetworkController extends GetxController {

  final List<MenuItem> _menuItems = MenuDataConstants.menuItems;

  static MenuDataNetworkController instance = Get.find();


  Future<List<Map<String, dynamic>>> getMenuData() async {
    await Future.delayed(Duration(milliseconds: 100));
    return _menuItems.map((item) => item.toMap()).toList();
  }
}
