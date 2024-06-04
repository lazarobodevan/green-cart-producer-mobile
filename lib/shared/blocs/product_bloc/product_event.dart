part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class AddNewProductEvent extends ProductEvent {
  PostProductModel productModel;

  AddNewProductEvent({required this.productModel});

  @override
  List<Object?> get props => [];
}

class ResetProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class ChangeProductInfoEvent extends ProductEvent {
  final String? name;
  final String? description;
  final List<ProductPictureMetadataModel>? picturesMetadata;
  final String? category;
  final List<File>? pictures;
  final String? price;
  final String? unit;
  final int? availableQuantity;
  final bool? isOrganic;
  final String? harvestDate;
  final String? producerId;

  const ChangeProductInfoEvent(
      {this.name,
      this.description,
      this.picturesMetadata,
      this.category,
      this.pictures,
      this.price,
      this.unit,
      this.availableQuantity,
      this.isOrganic,
      this.harvestDate,
      this.producerId});

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        description,
        picturesMetadata,
        category,
        pictures,
        price,
        unit,
        availableQuantity,
        isOrganic,
        harvestDate,
        producerId
      ];
}

class CreateProductPictureEvent extends ProductEvent {
  final File picture;
  final int index;

  const CreateProductPictureEvent({required this.picture, required this.index});

  @override
  List<Object?> get props => [picture, index];
}

class ReorderProductPicture extends ProductEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderProductPicture(
      {
      required this.oldIndex,
      required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class ConfirmReorderProductPicture extends ProductEvent{
  @override
  List<Object?> get props => [];

}

class LoadProductEvent extends ProductEvent {
  final String productId;

  const LoadProductEvent({required this.productId});

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}

class SendUpdateProductEvent extends ProductEvent {
  final UpdateProductModel productModel;

  const SendUpdateProductEvent({required this.productModel});

  @override
  List<Object?> get props => [productModel];
}
