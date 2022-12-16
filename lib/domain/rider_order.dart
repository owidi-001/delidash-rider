/*
[
  {id: 6,
  rider: {id: 6, user: 24, brand: z riders,dob: 54/54/5454, national_id: 64949946, license: tehhd62}, 
  item: {id: 32, cart:16, quantity: 1, 
    product: {id: 4, label: Star Coffee, unit: kg, unit_price: 300.00, image: /media/product/2022/11/21/starbucks-EspressoRoast.png, description: Have a taste of latte, stock: 15, created_at: 2022-11-29T21:47:46.842345Z, category: 4, vendor: 1}, status: On Transit},
  location: {id: 4, name: Njokerio Seventh Street  Njoro  Kenya, block_name: Bintihouse, floor_number: 2, room_number: B9}}]

*/

import 'package:flutter/foundation.dart';
import 'package:rider/domain/product.model.dart';
import 'package:rider/domain/rider.model.dart';

class Location {
  final int id;
  final String name;
  final String block_name;
  final String floor_number;
  final String room_number;

  const Location(
      {required this.id,
      required this.name,
      required this.block_name,
      required this.floor_number,
      required this.room_number});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json["id"],
        name: json["name"],
        block_name: json["block_name"],
        room_number: json["room_number"],
        floor_number: json["floor_number"]);
  }

  factory Location.empty() {
    // ignore: prefer_const_constructors
    return Location(
        id: 0,
        name: "Egerton University",
        block_name: "Science complex",
        room_number: "30",
        floor_number: "2");
  }
}

class OrderItem {
  final int id;
  final int cart;
  final int quantity;
  final Product product;
  final String status;
  final String date;
  final String time;

  const OrderItem(
      {required this.id,
      required this.cart,
      required this.quantity,
      required this.product,
      required this.status,
      required this.date,
      required this.time});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print(json);
    }

    return OrderItem(
        id: json["id"],
        cart: json["cart"],
        quantity: json["quantity"],
        status: json["status"],
        product: Product.fromJson(json["product"]),
        date: json["date"],
        time: json["time"]);
  }
}

class RiderOrder {
  final int id;
  final Rider rider;
  final Location location;
  final OrderItem item;

  RiderOrder(
      {required this.id,
      required this.rider,
      required this.location,
      required this.item});

  factory RiderOrder.fromJson(Map<String, dynamic> json) {
    return RiderOrder(
        id: json["id"],
        rider: Rider.fromJson(json["rider"]),
        location: Location.fromJson(json["location"]),
        item: OrderItem.fromJson(json["item"]));
  }
}
