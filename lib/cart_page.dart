import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/shoping_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<ShoppingProvider>();

    var cartProducts = myProvider.products
        .where((product) => product.isInCart)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
        actions: [
          IconButton(
            onPressed: () {
              myProvider.Clear();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProducts.length,

              itemBuilder: (context, index) {
                var product = cartProducts[index];

                return Card(
                  margin: EdgeInsets.all(10),

                  child: ListTile(
                    leading: Icon(product.icon, size: 35),

                    title: Text(product.name),

                    subtitle: Text(
                      "Total: ${product.price * product.quantity} EGP",
                    ),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<ShoppingProvider>().decreaseQuantity(
                              product.id,
                            );
                          },
                          icon: Icon(Icons.remove),
                        ),

                        Text("${product.quantity}"),

                        IconButton(
                          onPressed: () {
                            context.read<ShoppingProvider>().increaseQuantity(
                              product.id,
                            );
                          },
                          icon: Icon(Icons.add),
                        ),

                        IconButton(
                          icon: Icon(
                            Icons.remove_shopping_cart,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context.read<ShoppingProvider>().Change_Item_Status(
                              product.id,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // TOTAL SECTION
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Colors.blueGrey.shade100,

            child: Text(
              "TOTAL: ${myProvider.totalPrice} EGP",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
