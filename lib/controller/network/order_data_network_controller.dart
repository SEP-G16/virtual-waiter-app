import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:virtual_waiter/constants/network_constants.dart';

class OrderDataNetworkController extends GetxController {
  static OrderDataNetworkController instance = Get.find();

  Future<Map<String, dynamic>> sendOrder({required Map<String, dynamic> orderMap}) async {
    try {
      var response = await http.post(
        Uri.parse('${NetworkConstants.baseUrl}/api/order/add'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(orderMap),
      );

      if (response.statusCode != 201) {
        print(response.body);
        throw Exception('Failed to send order');
      }

      return jsonDecode(response.body);

    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getIncompleteOrders({required String sessionId}) async {
    try {
      var response = await http.get(
        Uri.parse('${NetworkConstants.baseUrl}/api/order/incomplete/$sessionId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        print(response.body);
        throw Exception('Failed to fetch incomplete orders');
      }

      List<dynamic> decoded = jsonDecode(response.body);
      return decoded.map<Map<String, dynamic>>((element) {
        Map<String, dynamic> map = element as Map<String, dynamic>;
        return map;
      }).toList();

    } on FormatException catch (e) {
      print(e);
      rethrow;
    }
  }
}
