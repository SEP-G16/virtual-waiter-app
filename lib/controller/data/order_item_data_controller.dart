import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_data_controller.dart';
import 'package:virtual_waiter/model/order.dart';

import '../../model/order_item.dart';
import '../network/order_data_network_controller.dart';

class OrderItemDataController extends GetxController{
  static OrderItemDataController instance = Get.find();

  final OrderDataNetworkController _orderDataNetworkController = OrderDataNetworkController.instance;

  final OrderDataController _odc = OrderDataController.instance;

  List<OrderItem> _orderItemList = [];
  List<OrderItem> get orderItemList => _orderItemList;
  RxList<OrderItem> listenableOrderItemList = <OrderItem>[].obs;

  void addOrderItem({required OrderItem orderItem}){
    _orderItemList.add(orderItem);
    _odc.addOrderItemToEditableOrder(orderItem: orderItem);
    listenableOrderItemList.add(orderItem);
    update();
  }

  void removeOrderItem({required int menuItemId}){
    _orderItemList.removeWhere((order) => order.menuItem.id == menuItemId);
    _odc.removeOrderItemFromEditableOrder(menuItemId: menuItemId);
    listenableOrderItemList.removeWhere((order) => order.menuItem.id == menuItemId);
    update();
  }

  bool orderItemAlreadyExists({required int menuItemId}){
    return _orderItemList.any((order) => order.menuItem.id == menuItemId);
  }

  OrderItem findByMenuItemId({required int id}) {
    if (orderItemAlreadyExists(menuItemId: id)) {
      return _orderItemList
          .where((order) => order.menuItem.id == id)
          .toList()
          .first;
    } else {
      throw Exception('Order Not Found');
    }
  }

  Future<void>completeOrder() async {
    try{
      //TODO: Use network controller
      await _odc.completeOrder();
    }catch(e){
      rethrow;
    }
  }
}
