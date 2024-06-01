import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_producer/models/product/post_request_models/post_product_model.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/post_request_models/update_product_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';
import 'package:mobile_producer/services/product_service.dart';

part 'update_product_event.dart';

part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductService productService;
  late UpdateProductModel productModel;

  UpdateProductBloc({required this.productService})
      : super(UpdateProductInitial()) {
    productModel = UpdateProductModel.empty();
    on<LoadProductEvent>((event, emit) async {
      try {
        emit(UpdateProductLoadingState());
        ProductModel productModelResponse =
            await productService.getProductById(event.productId);

        productModel = UpdateProductModel(
            id: event.productId,
            name: productModelResponse.name,
            description: productModelResponse.description,
            pictures: productModelResponse.pictures,
            newPictures: <File>[],
            picturesMetadata: <ProductPictureMetadataModel>[],
            category: productModelResponse.category,
            price: productModelResponse.price.toString(),
            unit: productModelResponse.unit,
            availableQuantity: productModelResponse.availableQuantity,
            isOrganic: productModelResponse.isOrganic,
            harvestDate: productModelResponse.harvestDate);

        emit(UpdateProductLoadedState(productModel: productModel));
        emit(UpdateInfoState(productModel: productModel));
      } catch (e) {
        emit(UpdateProductErrorState());
      }
    });

    on<UpdateProductInfoEvent>((event, emit) {
      _updateProduct(
        name: event.name,
        description: event.description,
        category: event.category,
        price: event.price,
        unit: event.unit,
        availableQuantity: event.availableQuantity,
        isOrganic: event.isOrganic,
        harvestDate: event.harvestDate,
      );
      emit(UpdateInfoState(productModel: productModel));
    });

    on<SendUpdateProductEvent>((event, emit)async{
      emit(SendingUpdateProductState());
      try{
        await ProductService().updateProduct(productModel);
        emit(SendedUpdateProductState());
      }catch(e){
        emit(ErrorSendingUpdateProductState());
      }
    });
  }

  UpdateProductModel get product => productModel;

  _updateProduct({
    String? name,
    String? description,
    String? category,
    String? price,
    String? unit,
    int? availableQuantity,
    bool? isOrganic,
    String? harvestDate,
  }) {
    productModel = productModel.copyWith(
      name: name,
      description: description,
      category: category,
      price: price,
      unit: unit,
      availableQuantity: availableQuantity,
      isOrganic: isOrganic,
      harvestDate: harvestDate,
    );
  }
}
