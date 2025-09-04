import 'package:bloc/bloc.dart';

import '../../repository/cart_repository.dart';
import 'card_event.dart';
import 'card_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repo;

  CartBloc(this.repo) : super(CartLoading()) {
    on<LoadCartEvent>((e, emit) async {
      final items = await repo.loadCart();
      if (items.isEmpty)
        emit(CartEmpty());
      else
        emit(CartLoaded(items));
    });

    on<AddToCartEvent>((e, emit) async {
      final current = state is CartLoaded
          ? List<CartItem>.from((state as CartLoaded).items)
          : [];
      final idx = current.indexWhere((c) => c.productId == e.item.productId);
      if (idx >= 0) {
        current[idx].quantity += e.item.quantity;
      } else {
        current.add(e.item);
      }
      for (var it in current) await repo.upsertItem(it);
      emit(CartLoaded(current));
    });

    on<UpdateQuantityEvent>((e, emit) async {
      final current = state is CartLoaded
          ? List<CartItem>.from((state as CartLoaded).items)
          : [];
      final idx = current.indexWhere((c) => c.productId == e.productId);
      if (idx >= 0) {
        current[idx].quantity = e.quantity;
        if (current[idx].quantity <= 0) {
          current.removeAt(idx);
          await repo.removeItem(e.productId);
        } else {
          await repo.upsertItem(current[idx]);
        }
      }
      if (current.isEmpty)
        emit(CartEmpty());
      else
        emit(CartLoaded(current));
    });

    on<RemoveFromCartEvent>((e, emit) async {
      final current = state is CartLoaded
          ? List<CartItem>.from((state as CartLoaded).items)
          : [];
      current.removeWhere((c) => c.productId == e.productId);
      await repo.removeItem(e.productId);
      if (current.isEmpty)
        emit(CartEmpty());
      else
        emit(CartLoaded(current));
    });
  }
}
