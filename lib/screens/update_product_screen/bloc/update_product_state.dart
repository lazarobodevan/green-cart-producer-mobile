part of 'update_product_bloc.dart';

abstract class UpdateProductState extends Equatable {
  const UpdateProductState();
}

class UpdateProductInitial extends UpdateProductState {
  @override
  List<Object> get props => [];
}

class UpdateInfoState extends UpdateProductState{

  final UpdateProductModel productModel;

  UpdateInfoState({required this.productModel});

  @override
  List<Object?> get props => [productModel];

}

class UpdatedProductState extends UpdateProductState{
  final UpdateProductModel productModel;

  UpdatedProductState({required this.productModel});
  @override
  // TODO: implement props
  List<Object?> get props => [productModel];

}

class UpdateProductLoadingState extends UpdateProductState{
  @override
  List<Object?> get props => [];
}

class UpdateProductLoadedState extends UpdateProductState{
  final UpdateProductModel productModel;

  UpdateProductLoadedState({required this.productModel});

  @override
  List<Object?> get props => [];
}

class SendingUpdateProductState extends UpdateProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class SendedUpdateProductState extends UpdateProductState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ErrorSendingUpdateProductState extends UpdateProductState{
  @override
  List<Object?> get props => [];

}

class UpdateProductErrorState extends UpdateProductState{
  @override
  List<Object?> get props =>[];
}
