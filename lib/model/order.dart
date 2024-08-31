import '../enums/order_status.dart';
import 'order_item.dart';

class Order{
  final int id;
  final List<OrderItem> orderItems;
  final OrderStatus status;

  Order({required this.id, required this.orderItems, this.status = OrderStatus.Pending});
}