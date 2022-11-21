/*
{

    "id": 1,
    "rider": {
        "id": 1,
        "user": 10,
        "license": "KENYANAKS"
    },
    "item": {
        "id": 1,
        "cart": 1,
        "quantity": 3,
        "product": {
            "id": 1,
            "label": "Chicken masala",
            "unit": "kg",
            "unit_price": "200.00",
            "image": "/media/product/2022/11/11/kfc_drumstick.png",
            "description": "The quick brown fox",
            "stock": 20,
            "category": null,
            "vendor": 1
        }
    }

},
*/
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rider/domain/product.model.dart';

class OrderItem {
  final int id;
  final int cart;
  final int quantity;
  final Product product;
  final String status;

  const OrderItem(
      {required this.id,
      required this.cart,
      required this.quantity,
      required this.product,
      required this.status
      });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        id: json["item"]["id"],
        cart: json["item"]["cart"],
        quantity: json["item"]["quantity"],
        status: json["item"]["status"],
        product: Product.fromJson(json["item"]["product"]));
  }
}
