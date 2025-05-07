import 'package:execrise1/models/product_model.dart';
import 'package:execrise1/static_data.dart';
import 'package:execrise1/ui/cart_page.dart';
import 'package:execrise1/ui/product_detail_page.dart';
import 'package:execrise1/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<ProductModel, int> cart = {};

  void addToCart(ProductModel product) {
    setState(() {
      cart.update(product, (qty) => qty + 1, ifAbsent: () => 1);
    });
  }

  double get total =>
      cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  int get totalItemsInCart =>
      cart.values.fold(0, (sum, quantity) => sum + quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("StudentID - 1276584"),
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShoppingCartPage(
                                    cart: cart,
                                    total: total,
                                  )));
                    },
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )),
                if (totalItemsInCart > 0)
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text(
                        totalItemsInCart.toString(),
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ],
            )
          ],
        ),
        body: Column(
          children: [
            Divider(height: 1),
            Expanded(
              child: GridView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    product: product,
                    onAdd: () => addToCart(product),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                  onAddToCart: () {
                                    addToCart(product);
                                  },
                                  product: product,
                                ))),
                  );
                },
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1, // Adjust height/width ratio as needed
                ),
              ),
            ),
          ],
        ));
  }
}
