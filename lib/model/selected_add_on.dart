import 'package:virtual_waiter/model/add_on.dart';

class SelectedAddOn{
  AddOn addOn;
  int  quantity;

  SelectedAddOn({required this.addOn, required this.quantity});

  Map<String, dynamic> toMap(){
    return {
      'id': null,
      'addOnId': addOn.id,
      'quantity': quantity,
    };
  }

}