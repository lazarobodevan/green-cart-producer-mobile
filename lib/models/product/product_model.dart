// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_producer/models/producer/producer_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';


ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  String description;
  List<ProductPictureModel> pictures;
  String category;
  double price;
  String unit;
  int availableQuantity;
  bool isOrganic;
  DateTime harvestDate;
  ProducerModel? producer;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;


  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictures,
    required this.category,
    required this.price,
    required this.unit,
    required this.availableQuantity,
    required this.isOrganic,
    required this.harvestDate,
    required this.producer,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  ProductModel.empty():
    id = "",
    name = "",
    description = "",
    pictures = <ProductPictureModel>[],
    category = "",
    price = 0,
    unit = "",
    availableQuantity = 0,
    isOrganic = false,
    harvestDate = DateTime.now(),
    producer = null,
    createdAt = DateTime.now(),
    updatedAt = DateTime.now(),
    deletedAt = DateTime.now();
  

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictures: List<ProductPictureModel>.from(json["pictures"].map((x) => ProductPictureModel.fromJson(x))),
    category: json["category"],
    price: json["price"].toDouble(),
    unit: json["unit"],
    availableQuantity: json["availableQuantity"],
    isOrganic: json["isOrganic"],
    harvestDate: DateTime.parse(json["harvestDate"]),
    producer: json["producer"] != null ? ProducerModel.fromJson(json["producer"]): null,
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    deletedAt: json["deletedAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictures": List<dynamic>.from(pictures.map((x) => x.toJson())),
    "category": category,
    "price": price,
    "unit": unit,
    "availableQuantity": availableQuantity,
    "isOrganic": isOrganic,
    "harvestDate": harvestDate.toIso8601String(),
    "producer": producer?.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "deletedAt": deletedAt,
  };
}

class Picture {
  String url;
  String productId;
  int position;

  Picture({
    required this.url,
    required this.productId,
    required this.position,
  });

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
    url: json["url"],
    productId: json["productId"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "productId": productId,
    "position": position,
  };
}