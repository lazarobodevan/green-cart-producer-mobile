// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:mobile_producer/models/producer/producer_model.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';

//PostProductModel postProductModelFromJson(String str) => PostProductModel.fromJson(json.decode(str));

String postProductModelToJson(PostProductModel data) =>
    json.encode(data.toJson());

class PostProductModel {
  String name;
  String description;
  List<ProductPictureMetadataModel> picturesMetadata;
  String category;
  List<File> pictures;
  String price;
  String unit;
  int availableQuantity;
  bool isOrganic;
  String harvestDate;
  String producerId;

  PostProductModel({
    required this.name,
    required this.description,
    required this.picturesMetadata,
    required this.pictures,
    required this.category,
    required this.price,
    required this.unit,
    required this.availableQuantity,
    required this.isOrganic,
    required this.harvestDate,
    required this.producerId,
  });

  PostProductModel.empty()
      : name = "",
        description = "",
        picturesMetadata = <ProductPictureMetadataModel>[],
        pictures = <File>[],
        category = "",
        price = "0",
        unit = "",
        availableQuantity = 0,
        isOrganic = false,
        harvestDate = "",
        producerId = "null";

  PostProductModel copyWith(
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
    return PostProductModel(
        name: name ?? this.name,
        description: description ?? this.description,
        picturesMetadata: picturesMetadata ?? this.picturesMetadata,
        pictures: pictures ?? this.pictures,
        category: category ?? this.category,
        price: price ?? this.price,
        unit: unit ?? this.unit,
        availableQuantity: availableQuantity ?? this.availableQuantity,
        isOrganic: isOrganic ?? this.isOrganic,
        harvestDate: harvestDate ?? this.harvestDate,
        producerId: producerId ?? this.producerId);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "pictures": List<ProductPictureMetadataModel>.from(
            picturesMetadata.map((x) => x.toJson())),
        "category": category,
        "price": price,
        "unit": unit,
        "availableQuantity": availableQuantity,
        "isOrganic": isOrganic,
        "harvestDate": harvestDate,
        "producerId": producerId,
      };
}
