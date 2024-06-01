// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';

UpdateProductModel updateProductModelFromJson(String str) =>
    UpdateProductModel.fromJson(json.decode(str));

String updateProductModelToJson(UpdateProductModel data) => json.encode(data.toJson());

class UpdateProductModel {
  String id;
  String name;
  String description;
  List<ProductPictureModel>? pictures;
  List<File>? newPictures;
  List<ProductPictureMetadataModel>? picturesMetadata;
  String category;
  String price;
  String unit;
  int availableQuantity;
  bool isOrganic;
  DateTime harvestDate;

  UpdateProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictures,
      this.newPictures,
      required this.category,
      required this.price,
      required this.unit,
      required this.availableQuantity,
      required this.isOrganic,
      required this.harvestDate,
      this.picturesMetadata});

  UpdateProductModel.empty()
      : id = "",
        name = "",
        description = "",
        pictures = <ProductPictureModel>[],
        picturesMetadata = <ProductPictureMetadataModel>[],
        newPictures = <File>[],
        category = "",
        price = 0.toString(),
        unit = "",
        availableQuantity = 0,
        isOrganic = false,
        harvestDate = DateTime.now();

  UpdateProductModel copyWith(
      {String? id,
      String? name,
      String? description,
      List<ProductPictureMetadataModel>? picturesMetadata,
      String? category,
      List<File>? pictures,
      String? price,
      String? unit,
      int? availableQuantity,
      bool? isOrganic,
      String? harvestDate,
      String? producerId}) {
    return UpdateProductModel(
      id: this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      pictures: this.pictures,
      picturesMetadata: picturesMetadata ?? this.picturesMetadata,
      newPictures: pictures ?? this.newPictures,
      category: category ?? this.category,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      isOrganic: isOrganic ?? this.isOrganic,
      harvestDate: /*harvestDate ??*/ this.harvestDate,
    );
  }

  factory UpdateProductModel.fromJson(Map<String, dynamic> json) =>
      UpdateProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictures: List<ProductPictureModel>.from(
            json["pictures"].map((x) => ProductPictureModel.fromJson(x))),
        category: json["category"],
        price: json["price"].toDouble(),
        unit: json["unit"],
        availableQuantity: json["availableQuantity"],
        isOrganic: json["isOrganic"],
        harvestDate: DateTime.parse(json["harvestDate"]),
      );

   toJson() =>{
    "id": id,
    "name": name,
    "description": description,
    "pictures": pictures != null
        ? List<dynamic>.from(pictures!.map((x) => x.toJson()))
        : null,
    "category": category,
    "price": price,
    "unit": unit,
    "availableQuantity": availableQuantity,
    "isOrganic": isOrganic,
    "harvestDate": DateFormat("dd/MM/yyyy").format(harvestDate),
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
