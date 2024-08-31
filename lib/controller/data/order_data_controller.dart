import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';

import '../../model/order_item.dart';
import '../network/order_data_network_controller.dart';

class OrderDataController extends GetxController{
  static OrderDataController instance = Get.find();

  final OrderDataNetworkController _orderDataNetworkController = OrderDataNetworkController.instance;

  List<OrderItem> _orderList = [];
  List<OrderItem> get orderList => _orderList;
  RxList<OrderItem> listenableOrderList = <OrderItem>[].obs;

  void addOrderItem({required OrderItem orderItem}){
    _orderList.add(orderItem);
    listenableOrderList.add(orderItem);
    update();
  }

  void removeOrderItem({required String menuItemId}){
    _orderList.removeWhere((order) => order.menuItemId == menuItemId);
    listenableOrderList.removeWhere((order) => order.menuItemId == menuItemId);
    update();
  }

  bool orderAlreadyExists({required String menuItemId}){
    return _orderList.any((order) => order.menuItemId == menuItemId);
  }

  OrderItem findByMenuItemId({required String id}) {
    if (orderAlreadyExists(menuItemId: id)) {
      return _orderList
          .where((order) => order.menuItemId == id)
          .toList()
          .first;
    } else {
      throw Exception('Order Not Found');
    }
  }

  Future<void>completeOrder() async {
    try{
      List<Map<String,dynamic>> orderDataMapList = _orderList.map<Map<String, dynamic>>((order) => order.toMap()).toList();
      await _orderDataNetworkController.sendOrder(mapList : orderDataMapList);
    }catch(e){
      rethrow;
    }
  }
}
