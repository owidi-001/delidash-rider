import 'dart:async';
import 'dart:convert';

import 'package:rider/domain/rider_order.dart';
import 'package:rider/routes/app_router.dart';
import 'package:http/http.dart';
import 'package:rider/utility/shared_preference.dart';

class AppService {
  Future<List<RiderOrder>> fetchOrderItems() async {
    List<RiderOrder> orders = [];

    String token = await UserPreferences().getToken();

    final response = await get(Uri.parse(ApiUrl.orders),
        headers: {"Authorization": "Token $token"});

    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body);

      orders =
          parsed.map<RiderOrder>((json) => RiderOrder.fromJson(json)).toList();
    } else {}
    return orders;
  }

  Future<Map<String, dynamic>> confirmDelivery(
      Map<String, dynamic> payload) async {
    Map<String, dynamic> result;

    String token = await UserPreferences().getToken();

    Response response = await patch(
      Uri.parse(ApiUrl.orders),
      headers: {"Authorization": "Token $token", "Accept": "application/json"},
      body: json.encode(payload),
      encoding: Encoding.getByName("utf-8"),
    );

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
