import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_producer/models/product/post_request_models/post_product_model.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';
import 'package:mobile_producer/services/product_service.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  late PostProductModel _product;

  ProductBloc({required this.productService})
      : super(ProductInitial()) {
    _product = PostProductModel.empty();
    on<UpdateProductEvent>((event, emit) async {
      _updateProduct(
        name: event.name,
        description: event.description,
        picturesMetadata: event.picturesMetadata,
        pictures: event.pictures,
        category: event.category,
        price: event.price,
        unit: event.unit,
        availableQuantity: event.availableQuantity,
        isOrganic: event.isOrganic,
        harvestDate: event.harvestDate,
        producerId: event.producerId,
      );
      emit(NewProductState(product: _product));
    });

    on<ResetProductEvent>((event, emit) async {
      _product = PostProductModel.empty();
      emit(NewProductState(product: _product));
    });

    on<AddNewProductEvent>((event, emit) async {
      try {
        emit(NewProductAddingState());
        var addedProduct = await productService.addNewProduct(_product);
        emit(NewProductAddedState(product: addedProduct));
      } catch (e) {
        emit(NewProductErrorState());
      }
    });
  }

  PostProductModel get product => _product;

  _updateProduct({
    String? name,
    String? description,
    List<ProductPictureMetadataModel>? picturesMetadata,
    List<File>? pictures,
    String? category,
    String? price,
    String? unit,
    int? availableQuantity,
    bool? isOrganic,
    String? harvestDate,
    String? producerId,
  }) {
    _product = _product.copyWith(
      name: name,
      description: description,
      pictures: pictures,
      picturesMetadata: picturesMetadata,
      category: category,
      price: price,
      unit: unit,
      availableQuantity: availableQuantity,
      isOrganic: isOrganic,
      harvestDate: harvestDate,
      producerId: producerId,
    );
  }
}