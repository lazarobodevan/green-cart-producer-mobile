part of 'product_bloc.dart';


abstract class ProductState extends Equatable{
  const ProductState();
}


class ProductInitial extends ProductState{
  final PostProductModel? product;

  const ProductInitial({this.product});
  @override
  List<Object?> get props => [];
}

class NewProductState extends ProductState {
  final PostProductModel product;

  @override
  List<Object?> get props => [product];

  const NewProductState({required this.product});
}

class NewProductAddingState extends ProductState{
  @override
  List<Object?> get props => [];
}

class NewProductAddedState extends ProductState{

  final ProductModel product;

  @override
  List<Object?> get props => [product];

  const NewProductAddedState({required this.product});
}

class NewProductErrorState extends ProductState{
  @override
  List<Object?> get props => [];
}

class UpdateProductLoadingState extends ProductState{
  @override
  List<Object?> get props => [];
}

class UpdateProductLoadedState extends ProductState{
  final UpdateProductModel productModel;

  const UpdateProductLoadedState({required this.productModel});

  @override
  List<Object?> get props => [];
}

class SendingUpdateProductState extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SentUpdateProductState extends ProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ErrorSendingUpdateProductState extends ProductState{
  @override
  List<Object?> get props => [];

}

class ProductPicturesReorderedState extends ProductState{
  final List<File> pictures;
  final List<ProductPictureMetadataModel> metadata;

  const ProductPicturesReorderedState({required this.pictures, required this.metadata});

  @override
  // TODO: implement props
  List<Object?> get props => [];


}