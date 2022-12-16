import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rider/domain/rider_order.dart';
import 'package:rider/routes/app_router.dart';
import 'package:http/http.dart';
import 'package:rider/utility/shared_preference.dart';

class AppService {
  // Fetch order items
  //  Future<HttpResult<OrderItem>> confirmDelivery({required Map<String, dynamic> data}) =>
  //     HttpClient.put2<OrderItem>(
  //       ApiUrl.ordersEdit,
  //       data: data,
  //       der: (data) => OrderItem.fromJson(data),
  //     );

  Future<List<RiderOrder>> fetchOrderItems() async {
    List<RiderOrder> orders = [];

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.orders),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      orders =
          parsed.map<RiderOrder>((json) => RiderOrder.fromJson(json)).toList();
    } else {
      if (kDebugMode) {
        print(response.body);
        print(response.statusCode);
      }
    }
    return orders;
  }

  Future<Map<String, dynamic>> confirmDelivery(
      Map<String, dynamic> payload) async {
    Map<String, dynamic> result;

    print(jsonEncode(payload));

    String token = await UserPreferences().getToken();

    Response response = await patch(
      Uri.parse(ApiUrl.orders),
      headers: {"Authorization": "Token $token", "Accept": "application/json"},
      body: json.encode(payload),
      encoding: Encoding.getByName("utf-8"),
    );

    print(response.body);
    if (response.statusCode == 202) {
      result = {'status': true, 'message': 'Order delivery confirmed'};
    } else {
      result = {
        'status': false,
        'message': 'Confirmation failed ${response.statusCode} ${response.body}'
      };
    }

    return result;
  }
}
