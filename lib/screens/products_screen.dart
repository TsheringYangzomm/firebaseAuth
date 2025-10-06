/*import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import '../models/product_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = [
      {
        "id": "1",
        "name": "iPhone 17 Pro Max",
        "price": 1299.0,
        "description": "Latest A18 chip, 6.9-inch Super Retina XDR display, 48MP camera system",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1692893988185"
      },
      {
        "id": "2",
        "name": "iPhone 16 Pro",
        "price": 1099.0,
        "description": "A17 Pro chip, 6.7-inch OLED, Advanced computational photography",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1692893988185"
      },
      {
        "id": "3",
        "name": "iPhone 15 Pro",
        "price": 999.0,
        "description": "Titanium design, Action button, USB-C connectivity",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-15-pro-finish-select-202309-6-1inch?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1692893988185"
      },
      {
        "id": "4",
        "name": "iPhone 14",
        "price": 799.0,
        "description": "A15 Bionic chip, Crash Detection, Emergency SOS via satellite",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-14-finish-select-202209-6-1inch?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1661027938736"
      },
      {
        "id": "5",
        "name": "iPhone SE (4th Gen)",
        "price": 499.0,
        "description": "Affordable iPhone with Touch ID and A16 Bionic chip",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-se-white-select-202207?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1654893619854"
      },
      {
        "id": "6",
        "name": "iPhone 13 Mini",
        "price": 599.0,
        "description": "Compact design with A15 Bionic and great battery life",
        "image": "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/iphone-13-mini-blue-select-2021?wid=5120&hei=2880&fmt=jpeg&qlt=80&.v=1629842712000"
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("📱 iPhone Store"),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search iPhones...",
                  prefixIcon: Icon(Icons.search, color: Colors.lightBlue[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
              ),
            ),
            
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(
                              product: Product.fromMap(product),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                product["image"] as String, // Fixed: explicit cast to String
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => 
                                  Container(
                                    width: 80,
                                    height: 80,
                                    color: Colors.lightBlue[100],
                                    child: Icon(Icons.phone_iphone, size: 40, color: Colors.lightBlue[700]),
                                  ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["name"] as String, // Fixed: explicit cast to String
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    product["description"] as String, // Fixed: explicit cast to String
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${product["price"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.lightBlue[700],
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // Add to Cart Button
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${product["name"] as String} added to cart!'), // Fixed cast
                                    backgroundColor: Colors.lightBlue[700],
                                  ),
                                );
                              },
                              icon: Icon(Icons.add_shopping_cart, color: Colors.lightBlue[700]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} */