import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as SIO;
import 'package:virtual_waiter/constants.dart';

class WebSocketController extends GetxController{
  static WebSocketController instance = Get.find();

  late SIO.Socket _socket;

  WebSocketController._();

  static Future<WebSocketController> create() async {
    WebSocketController controller = WebSocketController._();
    await controller._initController();
    return controller;
  }

  Future<void> _initController () async {
    try{
      _socket = SIO.io(baseUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      _socket.connect();
    }catch(e){
      print('Error establishing websocket connection.');
      rethrow;
    }
  }

  Future<void> sendHelpRequest() async {
    try{
      _socket.emit('triggerAlert');
    }
    catch(e){
      print('Error sending help request');
      rethrow;
    }
  }
}