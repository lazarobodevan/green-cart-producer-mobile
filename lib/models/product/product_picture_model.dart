// To parse this JSON data, do
//
//     final productPictureModel = productPictureModelFromJson(jsonString);

import 'dart:convert';

ProductPictureModel productPictureModelFromJson(String str) => ProductPictureModel.fromJson(json.decode(str));

String productPictureModelToJson(ProductPictureModel data) => json.encode(data.toJson());

class ProductPictureModel {
  String url;
  String productId;
  int position;

  ProductPictureModel({
    required this.url,
    required this.productId,
    required this.position,
  });

  factory ProductPictureModel.fromJson(Map<String, dynamic> json) => ProductPictureModel(
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
