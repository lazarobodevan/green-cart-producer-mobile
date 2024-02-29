import 'dart:convert';

import 'package:mobile_producer/models/location/location_model.dart';


ProducerModel producerModelFromJson(String str) => ProducerModel.fromJson(json.decode(str));

String producerModelToJson(ProducerModel data) => json.encode(data.toJson());

class ProducerModel {
  String id;
  String name;
  String email;
  String telephone;
  String? picture;
  String whereToFind;
  LocationModel location;
  int ratingsAvg;
  int ratingsCount;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;

  ProducerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.telephone,
    required this.picture,
    required this.whereToFind,
    required this.location,
    required this.ratingsAvg,
    required this.ratingsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ProducerModel.fromJson(Map<String, dynamic> json) => ProducerModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    telephone: json["telephone"],
    picture: json["picture"],
    whereToFind: json["whereToFind"],
    location: LocationModel.fromJson(json["location"]),
    ratingsAvg: json["ratingsAvg"],
    ratingsCount: json["ratingsCount"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "telephone": telephone,
    "picture": picture,
    "whereToFind": whereToFind,
    "location": location.toJson(),
    "ratingsAvg": ratingsAvg,
    "ratingsCount": ratingsCount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
  };
}