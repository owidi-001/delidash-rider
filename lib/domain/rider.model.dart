import 'dart:convert';

import 'package:equatable/equatable.dart';

Rider riderFromJson(String str) => Rider.fromJson(json.decode(str));
String riderToJson(Rider data) => json.encode(data.toMap());

// "brand","dob","national_id","license"
class Rider extends Equatable {
  final String brand;
  final String dob;
  final String national_id;
  final String license;
  final int user;

  const Rider({
    required this.brand,
    required this.dob,
    required this.national_id,
    required this.license,
    required this.user,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      brand: json["brand"],
      dob: json["dob"],
      national_id: json["national_id"],
      license: json["license"],
      user: json["user"],
    );
  }

  Map<String, dynamic> toJson(Rider rider) => {
        "brand": rider.brand,
        "dob": rider.dob,
        "national_id": rider.national_id,
        "license": rider.license,
        "user": rider.user
      };

  Map<String, dynamic> toMap() => {
        "brand": brand,
        "dob": dob,
        "national_id": national_id,
        "license": license,
        "user": user
      };

  @override
  List<Object?> get props => [
        brand,
        dob,
        license,
        national_id,
        user,
      ];

  @override
  String toString() {
    return jsonEncode(
      toJson(this),
    );
  }

  factory Rider.empty() =>  const Rider(
      brand: "Unknown",
      dob: "anonymous",
      license: "anonymous",
      national_id: "anonymous",
      user: -1
      );
}