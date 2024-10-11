import 'package:virtual_waiter/model/menu_item.dart';
import 'package:virtual_waiter/model/selected_add_on.dart';

import '../enums/order_item_status.dart';

class OrderItem {
  final MenuItem menuItem;
  final int itemQuantity;
  final List<SelectedAddOn> selectedAddOns;
  String? additionalNote;
  final double totalAmount;
  OrderItemStatus _status = OrderItemStatus.Editing;

  OrderItem({
    required this.menuItem,
    required this.itemQuantity,
    required this.selectedAddOns,
    this.additionalNote,
    required this.totalAmount,
    required OrderItemStatus status,
  }) : _status = status;

  OrderItemStatus get status => _status;
  set status(OrderItemStatus status) => _status = status;

  OrderItem copyWith({
    MenuItem? menuItem,
    int? itemQuantity,
    List<SelectedAddOn>? selectedAddOns,
    String? additionalNote,
    double? totalAmount,
    OrderItemStatus? status,
  }) {
    return OrderItem(
      menuItem: menuItem ?? this.menuItem,
      itemQuantity: itemQuantity ?? this.itemQuantity,
      selectedAddOns: selectedAddOns ?? this.selectedAddOns,
      additionalNote: additionalNote ?? this.additionalNote,
      totalAmount: totalAmount ?? this.totalAmount, status: status ?? OrderItemStatus.Editing,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'menuItemId': menuItem.toMap(),
      'itemQuantity': itemQuantity,
      'selectedAddOns': selectedAddOns.map((x) => x.toMap()).toList(),
      'additionalNote': additionalNote,
      'totalAmount': totalAmount,
    };
  }

}
