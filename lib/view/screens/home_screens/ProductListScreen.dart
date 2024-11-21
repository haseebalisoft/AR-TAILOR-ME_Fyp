import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  final String category;

  ProductListScreen({required this.category});

  // Sample products for different categories
  final Map<String, List<Product>> productData = {
    'T-Shirt': [
      Product(name: 'Formal Shirt', price: 1500, image: 'assets/formal1.png'),
      Product(name: 'Casual Shirt', price: 1200, image: 'assets/formal2.png'),
      Product(name: 'Party Wear', price: 2000, image: 'assets/formal3.png'),
    ],
    'Kids Suits': [
      Product(name: 'Kids Casual Suit', price: 1000, image: 'assets/kids1.png'),
      Product(name: 'Kids Formal Suit', price: 1800, image: 'assets/kids2.png'),
      Product(name: 'Kids Party Wear', price: 2000, image: 'assets/kids3.png'),
    ],
    'Kameez': [
      Product(name: 'Cotton Kameez', price: 1500, image: 'assets/kameez1.png'),
      Product(name: 'Silk Kameez', price: 2500, image: 'assets/kameez2.png'),
      Product(name: 'Embroidered Kameez', price: 3000, image: 'assets/kameez3.png'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    // Get the list of products for the selected category
    final products = productData[category] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$category Products'),
        backgroundColor: Color(0xff2a87ef),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return buildProductCard(product);
          },
        ),
      ),
    );
  }

  // Widget to build a product card
  Widget buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            product.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xff2a87ef),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'PKR ${product.price}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Model for Product
class Product {
  final String name;
  final int price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}
