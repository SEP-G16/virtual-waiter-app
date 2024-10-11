enum OrderItemStatus{
  Pending, Processing, Ready, Editing, Cancelled
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
      case OrderItemStatus.Ready:
        return 'Ready';
      case OrderItemStatus.Editing:
        return 'Editing';
      case OrderItemStatus.Cancelled:
        return 'Cancelled';
      default:
        return 'Editing';
    }
  }
}