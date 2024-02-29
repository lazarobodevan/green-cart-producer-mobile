part of 'product_bloc.dart';

abstract class ProductState{
  const ProductState();
}

class ProductInitial extends ProductState{


}

class NewProductState extends ProductState {
  final PostProductModel product;

  const NewProductState({required this.product});
}

class NewProductAddingState extends ProductState{

}

class NewProductAddedState extends ProductState{

  final ProductModel product;

  const NewProductAddedState({required this.product});


}

class NewProductErrorState extends ProductState{

}