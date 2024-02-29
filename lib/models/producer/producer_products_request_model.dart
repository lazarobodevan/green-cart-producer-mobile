// To parse this JSON data, do
//
//     final producerProductsRequest = producerProductsRequestFromJson(jsonString);

import 'dart:convert';

import 'package:mobile_producer/models/producer/producer_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';


ProducerProductsRequest producerProductsRequestFromJson(String str) =>
    ProducerProductsRequest.fromJson(json.decode(str));

String producerProductsRequestToJson(ProducerProductsRequest data) =>
    json.encode(data.toJson());

class ProducerProductsRequest {
  ProducerModel producer;
  Products products;

  ProducerProductsRequest({
    required this.producer,
    required this.products,
  });

  factory ProducerProductsRequest.fromJson(Map<String, dynamic> json) =>
      ProducerProductsRequest(
        producer: ProducerModel.fromJson(json["producer"]),
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "producer": producer.toJson(),
        "products": products.toJson(),
      };
}

class Products {
  int pages;
  int currentPage;
  int offset;
  String? nextUrl;
  String? previousUrl;
  List<ProductModel> data;

  Products({
    required this.pages,
    required this.currentPage,
    required this.offset,
    required this.nextUrl,
    required this.previousUrl,
    required this.data,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
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
        "data": List<ProductModel>.from(data.map((x) => x)),
      };
}
