import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<dynamic> items;

  CartLoaded(this.items);

  double get total => items.fold(0, (t, i) => t + i.price * i.quantity);

  @override
  List<Object?> get props => [items];
}

class CartEmpty extends CartState {}
