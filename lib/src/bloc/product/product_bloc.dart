import 'package:bloc/bloc.dart';
import 'package:mini_e_commerce_app/src/bloc/product/product_event.dart';
import 'package:mini_e_commerce_app/src/bloc/product/product_state.dart';

import '../../repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;

  ProductBloc(this.repo) : super(ProductInitial()) {
    on<LoadProductsEvent>((e, emit) async {
      emit(ProductLoading());
      try {
        final products = await repo.fetchProducts();
        emit(ProductLoaded(products));
      } catch (ex) {
        emit(ProductError(ex.toString()));
      }
    });
    on<RetryProductsEvent>((e, emit) => add(LoadProductsEvent()));
  }
}
