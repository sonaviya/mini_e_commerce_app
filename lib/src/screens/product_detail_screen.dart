import 'package:flutter/material.dart';
import '../bloc/card/card_bloc.dart';
import '../bloc/card/card_event.dart';
import '../models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/cart_repository.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Column(
        children: [
          Hero(
            tag: 'product_${product.id}',
            child: Image.network(product.image, height: 300),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(product.description),
          ),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24),
          ),
          ElevatedButton(
            onPressed: () {
              final item = CartItem(
                productId: product.id,
                title: product.title,
                price: product.price,
                quantity: 1,
                image: product.image,
              );
              context.read<CartBloc>().add(AddToCartEvent(item));
              Navigator.pop(context);
            },
            child: Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
