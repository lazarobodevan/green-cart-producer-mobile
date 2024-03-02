part of 'my_store_bloc.dart';

abstract class MyStoreState extends Equatable {
  const MyStoreState();
}

class MyStoreLoadingState extends MyStoreState {
  @override
  List<Object> get props => [];
}

class MyStoreLoadedState extends MyStoreState {
  final ProducerProductsRequest data;

  MyStoreLoadedState({required this.data});
  @override
  List<Object> get props => [data];
}

class MyStoreErrorState extends MyStoreState {
  @override
  List<Object> get props => [];
}

