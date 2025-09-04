import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_e_commerce_app/src/screens/setting_screen.dart';

import '../bloc/card/card_bloc.dart';
import '../bloc/card/card_event.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../repository/cart_repository.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini E-Commerce'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            ),
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SettingsScreen()),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading)
            return Center(child: CircularProgressIndicator());
          if (state is ProductError)
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Failed to load'),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ProductBloc>().add(RetryProductsEvent()),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          if (state is ProductLoaded) {
            final products = state.products;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                childAspectRatio: .7,
              ),
              itemCount: products.length,
              itemBuilder: (_, idx) {
                final p = products[idx];
                return Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'product_${p.id}',
                          child: Image.network(p.image, fit: BoxFit.contain),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          p.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text('\$${p.price.toStringAsFixed(2)}'),
                      ElevatedButton(
                        onPressed: () {
                          final item = CartItem(
                            productId: p.id,
                            title: p.title,
                            price: p.price,
                            quantity: 1,
                            image: p.image,
                          );
                          context.read<CartBloc>().add(AddToCartEvent(item));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: Text('Add to cart'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(product: p),
                          ),
                        ),
                        child: Text('View'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
