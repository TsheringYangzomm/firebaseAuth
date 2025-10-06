// lib/screens/shop_screen.dart (NEW/UPGRADED)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/product.dart'; 
import 'product_details_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  // Mock Data for the Shop
  final List<Product> mockProducts = const [
    Product(
      id: 'p1', name: 'ENHYPEN World Tour Shirt', 
      imageUrl: 'images/merch_shirt.jpeg', price: '45.00', 
      isLimited: false, artist: 'ENHYPEN',
    ),
    Product(
      id: 'p2', name: 'Dark Blood Album (Signed)', 
      imageUrl: 'images/merch_album.jpeg', price: '60.00', 
      isLimited: true, artist: 'ENHYPEN',
    ),
    Product(
      id: 'p3', name: 'Official Light Stick Ver. 3', 
      imageUrl: 'images/merch_lightstick.jpeg', price: '55.00', 
      isLimited: false, artist: 'ENHYPEN',
    ),
    Product(
      id: 'p4', name: 'Crimson Fanclub Pin Set', 
      imageUrl: 'images/merch_pin.jpeg', price: '25.00', 
      isLimited: false, artist: 'CRIMSON',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weverse Shop', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              // TODO: Navigate to Cart
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '🔥 Exclusive & Trending',
                style: theme.textTheme.titleMedium,
              ),
            ),
            
            // Grid View of Products
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // Important for nested scrolling
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7, // Adjust ratio for better look
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: mockProducts.length,
              itemBuilder: (context, index) {
                final product = mockProducts[index];
                return ProductCard(product: product);
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
// lib/screens/shop_screen.dart (UPDATED SNIPPET)

// ... (ShopScreen and Product model remain the same)

// lib/screens/shop_screen.dart (CORRECTED PRODUCTCARD WIDGET)

// ... (Product model and ShopScreen remain the same)

class ProductCard extends StatelessWidget {
  // CRITICAL FIX: Re-add the Product property and constructor
  final Product product;
  
  const ProductCard({super.key, required this.product}); // CRITICAL FIX: Re-add the constructor

  @override
  Widget build(BuildContext context) {
    // CRITICAL FIX: Re-add the theme variable
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () { // <--- CHANGE THE onTap FUNCTION HERE
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      // ... (onTap remains the same)
      child: Card(
        // ... (Card styling remains the same)
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Area (MAJOR UPDATE HERE)
            // Replace `Expanded` with `AspectRatio` to constrain the size
            AspectRatio(
              aspectRatio: 1 / 1, // Forces a perfect square box for the image
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                    child: Image.asset( 
                      'assets/${product.imageUrl}',
                      width: double.infinity,
                      height: double.infinity, // Use height: double.infinity to fill the AspectRatio box
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (product.isLimited)
                    // ... (Limited badge, now 'theme' is accessible)
                    Positioned(
                      top: 8, left: 8,
                      child: Container(
                        // ...
                        child: Text(
                          'LIMITED',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            // Product Info (CRITICAL FIX: Fixes errors on lines 160-188)
            Padding(
              padding: const EdgeInsets.all(8.0), // The error here was because it wasn't inside the Column of the Card.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Artist
                  Text(
                    product.artist,
                    style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor),
                  ),
                  const SizedBox(height: 2),
                  // Name
                  Text(
                    product.name,
                    style: theme.textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  // Price
                  Text(
                    '\$${product.price}',
                    style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}