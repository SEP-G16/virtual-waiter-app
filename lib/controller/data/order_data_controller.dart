import 'package:get/get.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/model/order.dart';

import '../../model/order_item.dart';

class OrderDataController extends GetxController{

  static OrderDataController instance = Get.find();

  List<Order> _orderList = [];
  List<Order> get orderList => _orderList;
  RxList<Order> listenableOrderList = <Order>[].obs;

  void addOrder({required Order order}){
    _orderList.add(order);
    listenableOrderList.assignAll(_orderList);
  }

  void updateEditableOrder({required Order order}){
    int index = _orderList.indexWhere((element) => element.status == OrderStatus.Editing);
    _orderList[index] = order;
    listenableOrderList.assignAll(_orderList);
  }

  void addOrderItemToEditableOrder({required OrderItem orderItem}){
    if(_orderList.any((order) => order.status == OrderStatus.Editing))
      {
        int index = _orderList.indexWhere((element) => element.status == OrderStatus.Editing);
        _orderList[index].orderItems.add(orderItem);
        listenableOrderList.assignAll(_orderList);
      }
    else
      {
        _orderList.add(Order(id: -1, orderItems: [orderItem], status: OrderStatus.Editing));
        listenableOrderList.assignAll(_orderList);
      }
  }

  void removeOrderItemFromEditableOrder({required int menuItemId}){
    if(_orderList.any((order) => order.status == OrderStatus.Editing))
    {
      int index = _orderList.indexWhere((element) => element.status == OrderStatus.Editing);
      Order order = _orderList[index];
      if(order.orderItems.any((order) => order.menuItem.id == menuItemId)) {
        order.orderItems.removeWhere((item) => item.menuItem.id == menuItemId);
        if(order.orderItems.isEmpty)
          {
            _orderList.removeAt(index);
          }
        else
          {
            _orderList[index] = order;
          }
      }
      listenableOrderList.assignAll(_orderList);
    }
  }

  Future<void> completeOrder() async
  {
    print("Called");
    //TODO: update to Pending Status
    if(_orderList.any((order) => order.status == OrderStatus.Editing))
    {
      int index = _orderList.indexWhere((element) => element.status == OrderStatus.Editing);
      Order order = _orderList[index];
      try{
        order.status = OrderStatus.Pending;
        order.orderItems.forEach((orderItem) {
          orderItem.status = OrderItemStatus.Pending;
        });
        _orderList[index] = order;
      }
      catch(e){
        print(e.toString());
        rethrow;
      }
      listenableOrderList.assignAll(_orderList);
      update();
    }
    else
      {
        throw Exception('No order to complete');
      }
  }
}