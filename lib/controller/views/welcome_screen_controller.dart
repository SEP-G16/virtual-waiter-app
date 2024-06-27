import 'package:get/get.dart';
import 'package:virtual_waiter/controller/network/web_socket_controller.dart';

class WelcomeScreenController extends GetxController {
  static WelcomeScreenController instance = Get.find();

  Future<void> onTapForRequestHelpBtn() async {
    try{
      WebSocketController wsc = WebSocketController.instance;
      await wsc.sendHelpRequest();
    }catch(e){
      print('Error on send help request onTap');
      rethrow;
    }
  }
}
