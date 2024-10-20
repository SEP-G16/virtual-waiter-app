import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_waiter/constants/network_constants.dart';

class TableNetworkController extends GetxController{
  static TableNetworkController instance = Get.find();

  Future<Map<String, dynamic>> getTableData(int tableId) async
  {
    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/table/by-id/$tableId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch table data');
      }
      Map<String, dynamic> decoded = jsonDecode(response.body);
      return decoded;
    } on FormatException catch (e) {
      print(e);
      rethrow;
    } catch(e){
      print(e);
      rethrow;
    }
  }
}