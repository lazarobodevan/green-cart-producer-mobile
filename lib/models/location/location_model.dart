// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  double latitude;
  double longitude;
  int radiusInKm;
  String city;
  String state;
  String address;
  String zipCode;

  LocationModel({
    required this.latitude,
    required this.longitude,
    required this.radiusInKm,
    required this.city,
    required this.state,
    required this.address,
    required this.zipCode,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    radiusInKm: json["radiusInKm"],
    city: json["city"],
    state: json["state"],
    address: json["address"],
    zipCode: json["zipCode"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "radiusInKm": radiusInKm,
    "city": city,
    "state": state,
    "address": address,
    "zipCode": zipCode,
  };
}
