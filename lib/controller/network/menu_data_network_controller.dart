import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_waiter/constants/network_constants.dart';

class MenuDataNetworkController extends GetxController {

  static MenuDataNetworkController instance = Get.find();

  Future<List<Map<String, dynamic>>> getMenuData() async {
    try{
      final response = await http.get(Uri.parse('${NetworkConstants.baseUrl}/api/menu/all'));
      if(response.statusCode == 200){
        List<Map<String, dynamic>> menuData = [];
        for(Map<String, dynamic> data in jsonDecode(response.body)){
          menuData.add(data);
        }
        return menuData;
      }else{
        throw Exception('Failed to load menu data');
      }
    }catch(e){
      rethrow;
    }
  }
}
