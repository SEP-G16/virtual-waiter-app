import 'package:get/get.dart';

class OrderDataNetworkController extends GetxController{

  static OrderDataNetworkController instance = Get.find();

  Future<void> sendOrder({required List<Map<String,dynamic>> mapList}) async{
    await Future.delayed(Duration(milliseconds: 500));
    print('Order Sent');
  }

}