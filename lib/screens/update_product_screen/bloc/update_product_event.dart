part of 'update_product_bloc.dart';

abstract class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();
}

class LoadProductEvent extends UpdateProductEvent {
  final String productId;

  LoadProductEvent({required this.productId});

  @override
  // TODO: implement props
  List<Object?> get props => [productId];
}

class UpdateProductInfoEvent extends UpdateProductEvent {
  final String? name;
  final String? description;
  final String? category;
  final String? price;
  final String? unit;
  final int? availableQuantity;
  final bool? isOrganic;
  final String? harvestDate;

  UpdateProductInfoEvent({
    this.name,
    this.description,
    this.category,
    this.price,
    this.unit,
    this.availableQuantity,
    this.isOrganic,
    this.harvestDate,
  });

  @override
  List<Object?> get props => [];
}

class SendUpdateProductEvent extends UpdateProductEvent{
  final UpdateProductModel productModel;

  const SendUpdateProductEvent({required this.productModel});

  @override
  List<Object?> get props =>[productModel];
}

class UpdatePicturesEvent extends UpdateProductEvent {
  final List<ProductPictureModel> picturesFromServer;
  final List<File?> newPictures;

  UpdatePicturesEvent(
      {required this.picturesFromServer, required this.newPictures});

  @override
  List<Object?> get props => [picturesFromServer, newPictures];
}
