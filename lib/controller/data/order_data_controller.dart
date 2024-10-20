import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/table_data_controller.dart';
import 'package:virtual_waiter/controller/network/order_data_network_controller.dart';
import 'package:virtual_waiter/enums/menu_item_status.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/enums/order_status.dart';
import 'package:virtual_waiter/model/order.dart';
import 'package:virtual_waiter/model/selected_add_on.dart';

import '../../model/add_on.dart';
import '../../model/menu_item.dart';
import '../../model/order_item.dart';

class OrderDataController extends GetxController {
  static OrderDataController instance = Get.find();

  final OrderDataNetworkController _odnc = OrderDataNetworkController.instance;

  final TableDataController _tdc = TableDataController.instance;

  List<Order> _orderList = [];

  List<Order> get orderList => _orderList;

  Future<void> resetOrderList() async
  {
    previousSession = false;
    _orderList = [];
    listenableOrderList.assignAll(_orderList);
    await _tdc.setSessionData();
  }

  RxList<Order> listenableOrderList = <Order>[].obs;

  OrderDataController._();

  static bool previousSession = false;

  static Future<OrderDataController> create() async {
    OrderDataController controller = OrderDataController._();
    await controller._initialize();
    return controller;
  }

  Future<void> _initialize() async {
    _orderList = [];
    listenableOrderList = <Order>[].obs;
    previousSession = false;
    if (_tdc.sessionId != null) {
      List<Map<String, dynamic>> incompleteOrders =
          await _odnc.getIncompleteOrders(sessionId: _tdc.sessionId!);

      if (incompleteOrders.isEmpty ||
          incompleteOrders
              .every((element) => element['status'] == 'Complete' || element['status'] == 'Cancelled')) {
        await _tdc.setSessionData();
      } else {
        previousSession = true;
        _orderList = incompleteOrders.map((orderMap) {
          // item list from backend
          List<Map<String, dynamic>> orderItems =
              (orderMap['orderItems'] as List<dynamic>)
                  .map((element) => element as Map<String, dynamic>)
                  .toList();

          //item list to be saved
          List<OrderItem> itemList = orderItems.map((orderItemMap) {
            //fetching menu item for order item
            MenuItem menuItem = MenuDataController.instance
                .findItemById(id: orderItemMap['menuItem']['id']);

            //fetching add ons for order item
            List<SelectedAddOn> selectedAddOns = [];
            List<Map<String, dynamic>> addOnsMapList =
                (orderItemMap['addOns'] as List<dynamic>)
                    .map((element) => element as Map<String, dynamic>)
                    .toList();
            selectedAddOns = addOnsMapList.map((addOnMap) {
              int addOnId = (addOnMap['addOnId'] as int);
              AddOn addOn = menuItem.addOns
                  .firstWhere((element) => element.id == addOnId);
              return SelectedAddOn(
                  addOn: addOn, quantity: addOnMap['quantity']);
            }).toList();

            return OrderItem.fromMap(orderItemMap, menuItem, selectedAddOns);
          }).toList();
          return Order.fromMap(orderMap, itemList);
        }).toList();
        listenableOrderList.assignAll(_orderList);
      }
    } else {
      await _tdc.setSessionData();
    }
  }

  void addOrder({required Order order}) {
    _orderList.add(order);
    listenableOrderList.assignAll(_orderList);
  }

  void updateEditableOrder({required Order order}) {
    int index = _orderList
        .indexWhere((element) => element.status == OrderStatus.Editing);
    _orderList[index] = order;
    listenableOrderList.assignAll(_orderList);
  }

  void addOrderItemToEditableOrder({required OrderItem orderItem}) {
    if (_orderList.any((order) => order.status == OrderStatus.Editing)) {
      int index = _orderList
          .indexWhere((element) => element.status == OrderStatus.Editing);
      _orderList[index].orderItems.add(orderItem);
      listenableOrderList.assignAll(_orderList);
    } else {
      _orderList.add(Order(
          id: -1,
          orderItems: [orderItem],
          status: OrderStatus.Editing,
          sessionId: TableDataController.instance.sessionId!));
      listenableOrderList.assignAll(_orderList);
    }
  }

  void removeOrderItemFromEditableOrder({required int menuItemId}) {
    if (_orderList.any((order) => order.status == OrderStatus.Editing)) {
      int index = _orderList
          .indexWhere((element) => element.status == OrderStatus.Editing);
      Order order = _orderList[index];
      if (order.orderItems.any((order) => order.menuItem.id == menuItemId)) {
        order.orderItems.removeWhere((item) => item.menuItem.id == menuItemId);
        if (order.orderItems.isEmpty) {
          _orderList.removeAt(index);
        } else {
          _orderList[index] = order;
        }
      }
      listenableOrderList.assignAll(_orderList);
    }
  }

  Future<void> completeOrder() async {
    if (_orderList.any((order) => order.status == OrderStatus.Editing)) {
      int index = _orderList
          .indexWhere((element) => element.status == OrderStatus.Editing);
      Order order = _orderList[index];

      Map<String, dynamic> orderMap = order.toMap();

      orderMap['table'] = TableDataController.instance.table.toMap();

      Map<String, dynamic> savedOrderMap =
          await _odnc.sendOrder(orderMap: orderMap);

      order.id = (savedOrderMap['id'] as int);
      order.status = OrderStatus.Pending;
      order.orderItems.forEach((orderItem) {
        orderItem.status = OrderItemStatus.Pending;
      });
      _orderList[index] = order;

      listenableOrderList.assignAll(_orderList);
      update();
    } else {
      throw Exception('No order to complete');
    }
  }

  void updateOrderItemStatus({required Map<String, dynamic> orderMap}) {
    int orderId = orderMap['id'];
    List<Map<String, dynamic>> orderItems = (orderMap['orderItems'] as List<dynamic>).map((orderItem) => orderItem as Map<String, dynamic>).toList();
    OrderStatus orderStatus = OrderStatus.fromString(orderMap['status']);
    List<Order> updatedOrderList = _orderList.map((order) {
      if (order.id == orderId) {
        List<OrderItem> updatedOrderItems = order.orderItems.map((orderItem) {
          Map<String, dynamic> orderItemMap = orderItems.firstWhere((element) =>
              element['menuItem']!['id']! == orderItem.menuItem.id);
          OrderItemStatus orderItemStatus =
              OrderItemStatus.fromString(orderItemMap['status']);
          return orderItem.copyWith(status: orderItemStatus);
        }).toList();
        return order.copyWith(
            orderItems: updatedOrderItems, status: orderStatus);
      }
      return order;
    }).toList();
    _orderList.assignAll(updatedOrderList);
    listenableOrderList.assignAll(updatedOrderList);
  }

  void updateOrderDueToManyItemStatusChange({required int menuItemId, required MenuItemStatus menuItemStatus}) {
    if(menuItemStatus == MenuItemStatus.OutOfStock)
      {
        _orderList = _orderList.map((order) {
          List<OrderItem> updatedOrderItems = order.orderItems.map((orderItem) {
            if (orderItem.menuItem.id == menuItemId && (orderItem.status == OrderItemStatus.Pending || orderItem.status == OrderItemStatus.Editing)) {
              return orderItem.copyWith(status: OrderItemStatus.Rejected);
            }
            return orderItem;
          }).toList();
          return order.copyWith(orderItems: updatedOrderItems);
        }).toList();

        listenableOrderList.assignAll(_orderList);
      }
  }
}
