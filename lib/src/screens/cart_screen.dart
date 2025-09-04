import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/card/card_bloc.dart';
import '../bloc/card/card_event.dart';
import '../bloc/card/card_state.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading)
            return Center(child: CircularProgressIndicator());
          if (state is CartEmpty) return Center(child: Text('Cart is empty'));
          if (state is CartLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (_, i) {
                      final it = state.items[i];
                      return ListTile(
                        leading: Image.network(it.image, width: 50, height: 50),
                        title: Text(it.title),
                        subtitle: Text('\$${it.price}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => context.read<CartBloc>().add(
                                UpdateQuantityEvent(
                                  it.productId,
                                  it.quantity - 1,
                                ),
                              ),
                            ),
                            Text('${it.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => context.read<CartBloc>().add(
                                UpdateQuantityEvent(
                                  it.productId,
                                  it.quantity + 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 20)),
                      Text(
                        '\$${state.total.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
