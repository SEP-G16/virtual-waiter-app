enum OrderItemStatus{
  Editing, Pending, Rejected, Processing, Complete;

  static OrderItemStatus fromString(String status){
    switch(status){
      case 'Editing':
        return OrderItemStatus.Editing;
      case 'Pending':
        return OrderItemStatus.Pending;
      case 'Rejected':
        return OrderItemStatus.Rejected;
      case 'Processing':
        return OrderItemStatus.Processing;
      case 'Complete':
        return OrderItemStatus.Complete;
      default:
        return OrderItemStatus.Editing;
    }
  }
}

extension OrderItemStatusExtension on OrderItemStatus{
  String toStringAsName()
  {
    switch(this)
    {
      case OrderItemStatus.Pending:
        return 'Pending';
      case OrderItemStatus.Processing:
        return 'Processing';
      case OrderItemStatus.Complete:
        return 'Complete';
      case OrderItemStatus.Editing:
        return 'Editing';
      case OrderItemStatus.Rejected:
        return 'Rejected';
      default:
        return 'Editing';
    }
  }
}