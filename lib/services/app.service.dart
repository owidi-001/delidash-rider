import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rider/domain/exception.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/routes/app_router.dart';
import 'package:rider/services/http_client.dart';
import 'package:http/http.dart';
import 'package:rider/utility/shared_preference.dart';

class AppService {
  // Fetch order items
   Future<HttpResult<OrderItem>> confirmDelivery({required Map<String, dynamic> data}) =>
      HttpClient.put2<OrderItem>(
        ApiUrl.ordersEdit,
        data: data,
        der: (data) => OrderItem.fromJson(data),
      );


  Future<List<OrderItem>> fetchOrderItems() async {
    List<OrderItem> orders = [];

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.orders),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);

      orders =
          parsed.map<OrderItem>((json) => OrderItem.fromJson(json)).toList();
      if (kDebugMode) {
        for (var order in orders) {
          print(order.status);
        }
      }
    } else {
      if (kDebugMode) {
        print(response.body);
        print(response.statusCode);
      }
    }

    return orders;
  }
}
