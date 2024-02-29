// To parse this JSON data, do
//
//     final productRequestModel = productRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_producer/models/product/product_model.dart';


ProductRequestModel productRequestModelFromJson(String str) => ProductRequestModel.fromJson(json.decode(str));

String productRequestModelToJson(ProductRequestModel data) => json.encode(data.toJson());

class ProductRequestModel {
  int pages;
  int currentPage;
  int offset;
  String? nextUrl;
  String? previousUrl;
  List<ProductModel> data;

  ProductRequestModel({
    required this.pages,
    required this.currentPage,
    required this.offset,
    required this.nextUrl,
    required this.previousUrl,
    required this.data,
  });

  factory ProductRequestModel.fromJson(Map<String, dynamic> json) => ProductRequestModel(
    pages: json["pages"],
    currentPage: json["currentPage"],
    offset: json["offset"],
    nextUrl: json["nextUrl"],
    previousUrl: json["previousUrl"],
    data: List<ProductModel>.from(json["data"].map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pages": pages,
    "currentPage": currentPage,
    "offset": offset,
    "nextUrl": nextUrl,
    "previousUrl": previousUrl,
    "data": List<ProductModel>.from(data.map((x) => x.toJson())),
  };
}