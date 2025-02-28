import 'dart:convert';

import 'package:http/http.dart';
import 'package:mobile_producer/environment.dart';
import 'package:mobile_producer/models/producer/producer_products_request_model.dart';
import 'package:mobile_producer/models/product/post_request_models/post_product_model.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_producer/models/product/post_request_models/update_product_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/shared/utils/http_utils.dart';
class ProductService{

  getProducerProducts(String producerId) async{
    try{
      Response response = await get(Uri.parse("${Environment.apiUrl}/Product/producerId=$producerId"));
      if(response.statusCode == 200){
        var producer = producerProductsRequestFromJson(response.body);
        return producer;
      }
      throw Exception("Erro ao buscar no servidor: ${response.body}");
    }catch(e){
      print(e);
      rethrow;
    }
  }

  addNewProduct(PostProductModel productModel)async {
    try{
      final url = "${Environment.apiUrl}/Product";

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields["name"] = productModel.name;
      request.fields["unit"] = productModel.unit;
      request.fields["price"] = productModel.price.toString();
      request.fields["category"] = productModel.category;
      request.fields["isOrganic"] = productModel.isOrganic.toString();
      request.fields["producerId"] = "3b264476-7b70-4f2d-b106-447481ea569a";
      request.fields["description"] = productModel.description;
      request.fields["harvestDate"] = productModel.harvestDate;
      request.fields["AvailableQuantity"] = productModel.availableQuantity.toString();

      for(var i = 0; i < productModel.picturesMetadata.length; i++){
        request.fields["PicturesMetadata[$i][Name]"] = productModel.picturesMetadata[i].name;
        request.fields["PicturesMetadata[$i][Position]"] = productModel.picturesMetadata[i].position.toString();
      }

      var picturesMultipart = await HttpUtils().convertFilesToMultipart(productModel.pictures);
      for(var pic in picturesMultipart){
        request.files.add(pic);
      }

      final response = await request.send();

      if(response.statusCode == 201){
        final body = await response.stream.bytesToString();
        var createdProduct = productModelFromJson(body);

        return createdProduct;
      }
      var responsedata = await response.stream.bytesToString();
      print(responsedata);
    }catch(e){
      print(e);
      rethrow;
    }
  }

  getProductById(String id) async {
    try {
      Response response = await get(
          Uri.parse("${Environment.apiUrl}/Product/id=$id"));
      if (response.statusCode == 200) {
        var productDetails = productModelFromJson(response.body);
        return productDetails;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  updateProduct(UpdateProductModel product) async {
    try{
      Response response = await put(Uri.parse("${Environment.apiUrl}/Product/"), body: updateProductModelToJson(product), headers: {
        "content-type" : "application/json",
        "accept" : "application/json",
      },);
      if(response.statusCode == 200){
        var updatedProduct = response.body;
        return updatedProduct;
      }
    }catch(e){
      print(e);
      rethrow;
    }
  }


}