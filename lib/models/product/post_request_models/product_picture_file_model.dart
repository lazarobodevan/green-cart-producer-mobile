import 'dart:convert';
import 'dart:io';


ProductPictureMetadataModel productPictureMetadataModelFromJson(String str) => ProductPictureMetadataModel.fromJson(json.decode(str));

String productPictureMetadataModelToJson(ProductPictureMetadataModel data) => json.encode(data.toJson());
class ProductPictureMetadataModel{

  final String name;
  final int position;

  ProductPictureMetadataModel({required this.name, required this.position});

  factory ProductPictureMetadataModel.fromJson(Map<String, dynamic> json) => ProductPictureMetadataModel(
    name: json["name"],
    position: json["position"]
  );

  Map<String, dynamic> toJson() => {

    "name": name,
    "position": position
  };
}