import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile_producer/models/product/post_request_models/post_product_model.dart';
import 'package:mobile_producer/models/product/post_request_models/product_picture_file_model.dart';
import 'package:mobile_producer/models/product/post_request_models/update_product_model.dart';
import 'package:mobile_producer/models/product/product_model.dart';
import 'package:mobile_producer/models/product/product_picture_model.dart';
import 'package:mobile_producer/services/product_service.dart';
import 'package:path/path.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductService productService;
  late PostProductModel _product;
  late UpdateProductModel _updateProductModel;
  late List<File> _picturesCopy;
  late List<ProductPictureMetadataModel> _picturesMetadataCopy;

  PostProductModel get product => _product;

  UpdateProductModel get updateProduct => _updateProductModel;

  List<File> get picturesCopy => _picturesCopy;
  List<ProductPictureMetadataModel> get picturesMetadataCopy => _picturesMetadataCopy;

  _changeProduct({
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
    _picturesCopy = List.from(_product.pictures);
    _picturesMetadataCopy = _product.picturesMetadata.toList();
  }

  ProductBloc({required this.productService}) : super(ProductInitial()) {
    _product = PostProductModel.empty();
    _updateProductModel = UpdateProductModel.empty();

    on<ChangeProductInfoEvent>((event, emit) {
      _changeProduct(
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

    on<CreateProductPictureEvent>((event, emit) {
      var pictures = product.pictures;
      var metadata = product.picturesMetadata;

      if (event.index < pictures.length) {
        pictures[event.index] = event.picture;
        metadata[event.index] = ProductPictureMetadataModel(
            name: basename(event.picture.path), position: event.index);
      } else {
        pictures.add(event.picture);
        metadata.add(ProductPictureMetadataModel(
            name: basename(event.picture.path), position: pictures.length - 1));
      }
    });

    on<ReorderProductPicture>((event, emit){
        //Reorder metadata
        var prevPic = _picturesMetadataCopy[event.newIndex];
        _picturesMetadataCopy[event.newIndex] = _picturesMetadataCopy[event.oldIndex];
        _picturesMetadataCopy[event.oldIndex] = prevPic;
        _picturesMetadataCopy[event.newIndex].position = event.newIndex;
        _picturesMetadataCopy[event.oldIndex].position = event.oldIndex;

        //Reorder files
        var prevFile = _picturesCopy[event.newIndex];
        _picturesCopy[event.newIndex] = _picturesCopy[event.oldIndex];
        _picturesCopy[event.oldIndex] = prevFile;

        emit(ProductPicturesReorderedState(pictures: _picturesCopy, metadata: _picturesMetadataCopy));
    });

    on<ConfirmReorderProductPicture>((event,emit){
        product.picturesMetadata = _picturesMetadataCopy;
        product.pictures = _picturesCopy;
        _picturesMetadataCopy = [];
        _picturesCopy = [];
        emit(NewProductState(product: _product));
    });


  }
}
