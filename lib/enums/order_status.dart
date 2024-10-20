enum OrderStatus{
  Editing, Pending, Processing, Complete, Cancelled, Pending_Payment;

  static OrderStatus fromString(String status){
    switch(status){
      case 'Editing':
        return OrderStatus.Editing;
      case 'Pending':
        return OrderStatus.Pending;
      case 'Processing':
        return OrderStatus.Processing;
      case 'Complete':
        return OrderStatus.Complete;
      case 'Cancelled':
        return OrderStatus.Cancelled;
      case 'Pending_Payment':
        return OrderStatus.Pending_Payment;
      default:
        return OrderStatus.Editing;
    }
  }
}

extension OrderStatusExtension on OrderStatus{
  String get status{
    switch(this){
      case OrderStatus.Editing:
        return 'Editing';
      case OrderStatus.Pending:
        return 'Pending';
      case OrderStatus.Processing:
        return 'Processing';
      case OrderStatus.Complete:
        return 'Complete';
      case OrderStatus.Cancelled:
        return 'Cancelled';
      case OrderStatus.Pending_Payment:
        return 'Pending Payment';
      default:
        return '';
    }
  }
}