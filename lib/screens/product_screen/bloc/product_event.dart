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

class ResetProductEvent extends ProductEvent{
  @override
  List<Object?> get props => [];

}

class UpdateProductEvent extends ProductEvent {
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

  UpdateProductEvent(
      { this.name,
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
  List<Object?> get props => throw UnimplementedError();
}
