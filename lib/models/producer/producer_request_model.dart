// To parse this JSON data, do
//
//     final producerRequestModel = producerRequestModelFromJson(jsonString);

import 'dart:convert';
import 'package:mobile_producer/models/producer/producer_model.dart';


ProducerRequestModel producerRequestModelFromJson(String str) => ProducerRequestModel.fromJson(json.decode(str));

String producerRequestModelToJson(ProducerRequestModel data) => json.encode(data.toJson());

class ProducerRequestModel {
  int pages;
  int currentPage;
  int offset;
  String? nextUrl;
  String? previousUrl;
  List<ProducerModel> data;

  ProducerRequestModel({
    required this.pages,
    required this.currentPage,
    required this.offset,
    required this.nextUrl,
    required this.previousUrl,
    required this.data,
  });

  factory ProducerRequestModel.fromJson(Map<String, dynamic> json) => ProducerRequestModel(
    pages: json["pages"],
    currentPage: json["currentPage"],
    offset: json["offset"],
    nextUrl: json["nextUrl"],
    previousUrl: json["previousUrl"],
    data: List<ProducerModel>.from(json["data"].map((x) => ProducerModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": pages,
    "currentPage": currentPage,
    "offset": offset,
    "nextUrl": nextUrl,
    "previousUrl": previousUrl,
    "data": List<ProducerModel>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String name;
  String email;
  String telephone;
  dynamic picture;
  String whereToFind;
  double latitude;
  dynamic location;
  double longitude;
  int ratingsAvg;
  int ratingsCount;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.telephone,
    required this.picture,
    required this.whereToFind,
    required this.latitude,
    required this.location,
    required this.longitude,
    required this.ratingsAvg,
    required this.ratingsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    telephone: json["telephone"],
    picture: json["picture"],
    whereToFind: json["whereToFind"],
    latitude: json["latitude"]?.toDouble(),
    location: json["location"],
    longitude: json["longitude"]?.toDouble(),
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
    "latitude": latitude,
    "location": location,
    "longitude": longitude,
    "ratingsAvg": ratingsAvg,
    "ratingsCount": ratingsCount,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
  };
}
