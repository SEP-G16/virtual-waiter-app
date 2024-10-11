import '../enums/order_status.dart';
import 'order_item.dart';

class Order{
  int id;
  List<OrderItem> orderItems;
  OrderStatus _status = OrderStatus.Editing;

  Order({required this.id, required this.orderItems, required OrderStatus status}) {
    _status = status;
  }

  OrderStatus get status => _status;
  set status(OrderStatus status) => _status = status;
}