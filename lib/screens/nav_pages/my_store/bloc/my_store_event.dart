part of 'my_store_bloc.dart';

abstract class MyStoreEvent extends Equatable {
  const MyStoreEvent();
}

class MyStoreLoadProductsEvent extends MyStoreEvent{
  final String producerId;

  MyStoreLoadProductsEvent({required this.producerId});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}