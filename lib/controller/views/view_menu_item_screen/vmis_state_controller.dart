import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:virtual_waiter/controller/data/menu_data_controller.dart';
import 'package:virtual_waiter/controller/data/order_item_data_controller.dart';
import 'package:virtual_waiter/enums/order_item_status.dart';
import 'package:virtual_waiter/model/menu_item.dart';
import 'package:virtual_waiter/model/order_item.dart';

import '../../../model/selected_add_on.dart';

//vmis -view menu item screen
class VmisStateController extends GetxController {
  static VmisStateController instance = Get.find();

  final MenuDataController _menuDataController = MenuDataController.instance;
  final OrderItemDataController _orderListDataController = OrderItemDataController.instance;

  Map<int, int> _selectedAddOnsDataMap = {};
  Map<int, RxInt> _selectedAddOnsQuantityMap = {};

  RxBool _editingMode = false.obs;

  bool get editingMode => _editingMode.value;

  MenuItem? _menuItem;

  MenuItem get menuItem => _menuItem!;

  set menuItem(MenuItem item) {
    _menuItem = item;
    _selectedAddOnsDataMap = {};
    _selectedAddOnsQuantityMap = {};
    _totalAmount.value = item.price;
  }

  RxInt _quantity = 1.obs;

  int get quantity => _quantity.value;

  set quantity(int newQuantity) {
    _quantity.value = quantity;
    update();
  }

  RxDouble _totalAmount = 0.0.obs;

  double get totalAmount => _totalAmount.value;

  String? _additionalNotes = '';

  String? get additionalNotes => _additionalNotes;

  set additionalNotes(String? value) => _additionalNotes = value;

  void itemNotNullCheck() {
    if (_menuItem == null) {
      throw Exception('MenuItem menuItem is null');
    }
  }

  void incrementQuantity() {
    itemNotNullCheck();
    int curr = _quantity.value;
    curr++;
    _quantity.value = curr;
    _calculateTotal();
    update();
  }

  void decrementQuantity() {
    itemNotNullCheck();
    int curr = _quantity.value;

    for (int addOnId in _selectedAddOnsQuantityMap.keys) {
      int addOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
      if (curr > 1 && curr == addOnQuantity) {
        addOnQuantity--;
        _selectedAddOnsQuantityMap[addOnId]!.value = addOnQuantity;
      }
    }

    if (curr > 1) {
      curr--;
      _quantity.value = curr;
    }
    _calculateTotal();
    update();
  }

  void resetData() {
    _menuItem = null;
    _quantity.value = 1;
    _selectedAddOnsQuantityMap = {};
    _selectedAddOnsDataMap = {};
    _totalAmount.value = 0;
    _editingMode.value = false;
  }

  void addAddOnToDataMap({required int addOnId}) {
    itemNotNullCheck();
    _selectedAddOnsQuantityMap[addOnId] = 1.obs;
    _calculateTotal();
  }

  void removeAddOnFromDataMap({required int addOnId}) {
    itemNotNullCheck();
    _selectedAddOnsQuantityMap.remove(addOnId);
    _calculateTotal();
  }

  void incrementAddOnQuantity({required int addOnId}) {
    itemNotNullCheck();
    int currAddOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
    if (currAddOnQuantity < _quantity.value) {
      currAddOnQuantity++;
      _selectedAddOnsQuantityMap[addOnId]!.value = currAddOnQuantity;
      _calculateTotal();
      update();
    }
  }

  void decrementAddOnQuantity({required int addOnId}) {
    itemNotNullCheck();
    int currAddOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
    if (currAddOnQuantity > 1) {
      currAddOnQuantity--;
      _selectedAddOnsQuantityMap[addOnId]!.value = currAddOnQuantity;
      _calculateTotal();
      update();
    }
  }

  int getAddOnQuantityValue({required int addOnId}) {
    return _selectedAddOnsQuantityMap[addOnId]!.value;
  }

  void _calculateTotal() {
    itemNotNullCheck();
    double totalBasePrice = menuItem.price * _quantity.value;
    double totalAddOnPrice = 0.0;
    for (int addOnId in _selectedAddOnsQuantityMap.keys) {
      int addOnQuantity = _selectedAddOnsQuantityMap[addOnId]!.value;
      double addOnPrice = menuItem.addOns
          .where((addOn) => addOn.id == addOnId)
          .toList()
          .first
          .price;
      totalAddOnPrice += addOnQuantity * addOnPrice;
    }
    _totalAmount.value = totalAddOnPrice + totalBasePrice;
  }

  void _fillSelectedAddOnsDataMap() {
    _selectedAddOnsDataMap = {};
    for (var entry in _selectedAddOnsQuantityMap.entries) {
      int addOnId = entry.key;
      int addOnQuantity = entry.value.value;
      _selectedAddOnsDataMap[addOnId] = addOnQuantity;
    }
  }

  void addOrder() {
    itemNotNullCheck();
    _fillSelectedAddOnsDataMap();
    _orderListDataController.addOrderItem(
      orderItem: OrderItem(
        status: OrderItemStatus.Editing,
        menuItem: menuItem,
        itemQuantity: _quantity.value,
        selectedAddOns: _selectedAddOnsDataMap.entries.map((entry) {
          int addOnId = entry.key;
          int addOnQuantity = entry.value;
          return SelectedAddOn(
            addOn: menuItem.addOns
                .where((addOn) => addOn.id == addOnId)
                .toList()
                .first,
            quantity: addOnQuantity,
          );
        }).toList(),
        additionalNote: _additionalNotes,
        totalAmount: totalAmount,
      ),
    );
  }

  void initByOrderItem({required OrderItem orderItem}) {
    _menuItem = orderItem.menuItem;
    itemNotNullCheck();
    _editingMode.value = true;
    _quantity.value = orderItem.itemQuantity;
    _additionalNotes = orderItem.additionalNote;
    for (SelectedAddOn selectedAddOn in orderItem.selectedAddOns) {
      _selectedAddOnsQuantityMap[selectedAddOn.addOn.id] = 1.obs;
      _selectedAddOnsQuantityMap[selectedAddOn.addOn.id]!.value =
          selectedAddOn.quantity;
    }
    _totalAmount.value = orderItem.totalAmount;
  }

  bool checkAddOnAlreadyAdded({required int addOnId}) {
    return _selectedAddOnsQuantityMap.keys.any((id) => id == addOnId);
  }

  void updateOrder() {
    itemNotNullCheck();
    if (_orderListDataController.orderItemAlreadyExists(menuItemId: _menuItem!.id)) {
      _orderListDataController.removeOrderItem(menuItemId: _menuItem!.id);
      _fillSelectedAddOnsDataMap();
      _orderListDataController.addOrderItem(
        orderItem: OrderItem(
          status: OrderItemStatus.Editing,
          menuItem: menuItem,
          itemQuantity: _quantity.value,
          selectedAddOns: _selectedAddOnsDataMap.entries.map((entry){
            int addOnId = entry.key;
            int addOnQuantity = entry.value;
            return SelectedAddOn(
              addOn: menuItem.addOns
                  .where((addOn) => addOn.id == addOnId)
                  .toList()
                  .first,
              quantity: addOnQuantity,
            );
          }).toList(),
          totalAmount: _totalAmount.value,
        ),
      );
    }
  }
}
