import 'package:get/get.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/model/order_item.dart';

import '../../data/menu_data_controller.dart';

class OssController extends GetxController {
  final MenuDataController _mdc = MenuDataController.instance;
  late final OrderItemDataController _odc;

  RxList<OrderItem> _orderItems = <OrderItem>[].obs;
  List<OrderItem> get orderItems => _orderItems;

  static OssController instance = Get.find();

  RxDouble _totalAmount = 0.0.obs;
  double get totalAmount => _totalAmount.value;

  //TODO: Sort orders by category order
  void analyseOrderData() {
    _orderItems.value = _odc.orderItemList;
    _totalAmount.value = _orderItems.fold(
        0, (previousValue, element) => previousValue + element.totalAmount);
    update();
  }

  void removeOrderItem({required int menuItemId}) {
    if (_orderItems.any((order) => order.menuItem.id == menuItemId)) {
      _orderItems
          .removeWhere((order) => order.menuItem.id == menuItemId);
      _odc.removeOrderItem(menuItemId: menuItemId);
      update();
    }
  }

  OrderItem findOrderItemByMenuItemId({required int id}) {
    return _odc.findByMenuItemId(id : id);
  }

  Future<void> completeOrder () async{
   try{
     await _odc.completeOrder();
     return;
   }catch(e){
     throw Exception('Cannot complete order');
   }
  }
  void _onItemsChanged(List<OrderItem> items) {
    analyseOrderData();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    ever(_odc.listenableOrderItemList, _onItemsChanged);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _odc = OrderItemDataController.instance;
  }
}
