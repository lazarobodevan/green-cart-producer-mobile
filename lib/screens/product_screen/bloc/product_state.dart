part of 'product_bloc.dart';

abstract class ProductState extends Equatable{
  const ProductState();
}

class ProductInitial extends ProductState{
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