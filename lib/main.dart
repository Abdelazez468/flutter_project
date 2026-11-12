import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/shoping_provider.dart';
import 'cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyWidget());
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var myProvider = context.watch<ShoppingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("shopping App"),
        backgroundColor: const Color.fromARGB(255, 3, 211, 200),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage()),
              );
            },

            icon: Row(
              children: [
                Icon(Icons.shopping_cart),
                SizedBox(width: 5),
                Text(myProvider.cartCount.toString()),
              ],
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.all(10),

        child: GridView.builder(
          itemCount: myProvider.products.length,

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),

          itemBuilder: (context, index) {
            var product = myProvider.products[index];

            return Card(
              elevation: 4,

              child: Padding(
                padding: EdgeInsets.all(10),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    Icon(product.icon, size: 65, color: Colors.blueGrey),

                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text("${product.price} EGP"),

                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<ShoppingProvider>().Change_Item_Status(
                          product.id,
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: product.isInCart
                            ? Colors.red
                            : Colors.blue,

                        foregroundColor: Colors.white,
                      ),

                      icon: Icon(
                        product.isInCart
                            ? Icons.remove_shopping_cart
                            : Icons.add_shopping_cart,
                      ),

                      label: Text(product.isInCart ? "Remove" : "Add to Cart"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
