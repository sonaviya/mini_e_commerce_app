import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_e_commerce_app/src/bloc/card/card_bloc.dart';
import 'package:mini_e_commerce_app/src/bloc/card/card_event.dart';
import 'package:mini_e_commerce_app/src/bloc/product/product_bloc.dart';
import 'package:mini_e_commerce_app/src/bloc/product/product_event.dart';
import 'package:mini_e_commerce_app/src/bloc/setting/setting_bloc.dart';
import 'src/app.dart';
import 'src/repository/product_repository.dart';

import 'src/repository/cart_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final productRepo = ProductRepository();
  final cartRepo = await CartRepository.getInstance();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProductRepository>(create: (_) => productRepo),
        RepositoryProvider<CartRepository>(create: (_) => cartRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ProductBloc>(
            create: (context) =>
                ProductBloc(productRepo)..add(LoadProductsEvent()),
          ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(cartRepo)..add(LoadCartEvent()),
          ),
          BlocProvider<SettingsCubit>(create: (_) => SettingsCubit()),
        ],
        child: MyApp(),
      ),
    ),
  );
}
