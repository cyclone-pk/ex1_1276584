import 'package:execrise1/models/product_model.dart';
import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  final Map<ProductModel, int> cart;
  final double total;

  const ShoppingCartPage({
    Key? key,
    required this.cart,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final entry = cart.entries.elementAt(index);
                      final product = entry.key;
                      final quantity = entry.value;
                      final subtotal = product.price * quantity;

                      return ListTile(
                        leading: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6)),
                          child: Image.network(
                            product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(product.name),
                        subtitle:
                            Text('${product.description}\nQty: $quantity'),
                        trailing: Text('\$${subtotal.toStringAsFixed(2)}'),
                        isThreeLine: true,
                      );
                    },
                  ),
                ),
                const Divider(height: 0),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text('\$${total.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Checkout coming soon...'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // button background color
                        foregroundColor: Colors.white, // text color
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Proceed to Checkout',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
