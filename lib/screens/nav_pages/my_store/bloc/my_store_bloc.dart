import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_producer/models/producer/producer_products_request_model.dart';
import 'package:mobile_producer/services/product_service.dart';

part 'my_store_event.dart';
part 'my_store_state.dart';

class MyStoreBloc extends Bloc<MyStoreEvent, MyStoreState> {
  final ProductService productService;
  MyStoreBloc({required this.productService}) : super(MyStoreLoadingState()) {
    on<MyStoreLoadProductsEvent>((event, emit) async {
      try{
        var producer = await this.productService.getProducerProducts(event.producerId);

        emit(MyStoreLoadedState(data: producer));
      }catch(e){
        emit(MyStoreErrorState());
      }
    });
  }
}
