import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/product.dart'; // Ensure your Product model is imported

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  // The screen requires a product to display
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // CRITICAL FIX: Define the parsed price here, so it can be used everywhere.
    // Safely converts the String price to a double, defaulting to 0.0 if invalid.
    final double parsedPrice = double.tryParse(product.price) ?? 0.0;
    
    return Scaffold(
      // App Bar remains simple for context
      appBar: AppBar(
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      
      // Bottom Bar for 'Add to Cart' or 'Buy Now'
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        color: AppTheme.backgroundColor,
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement actual 'Add to Cart' logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${product.name} added to cart!')),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            // FIX 1: Use the correct variable 'parsedPrice'
            'BUY NOW - \$${parsedPrice.toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.black, // Contrast color on the primary button
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      // Scrollable Body Content
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. PRODUCT IMAGE (Large size)
            AspectRatio(
              aspectRatio: 1 / 1, // Keep it square or adjust as needed
              child: Image.asset(
                'assets/${product.imageUrl}',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppTheme.surfaceColor,
                    child: const Icon(Icons.error, color: AppTheme.mutedColor),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. ARTIST & LIMITED BADGE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.artist,
                        style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.mutedColor),
                      ),
                      if (product.isLimited)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'LIMITED',
                            style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // 3. PRODUCT NAME & PRICE
                  Text(
                    product.name,
                    style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // FIX 2: Use the correct variable 'parsedPrice'
                    '\$${parsedPrice.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineMedium?.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.bold),
                  ),
                  const Divider(height: 32, color: AppTheme.surfaceColor),

                  // 4. DESCRIPTION (Placeholder - assuming product model has one)
                  Text(
                    'Product Description:',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    // Placeholder text since your model might not have this yet
                    'The official World Tour T-Shirt, featuring high-quality print and premium cotton. '
                    'Perfect for concerts and everyday wear. Available in sizes S, M, L, XL.',
                    style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.mutedColor),
                  ),
                  const Divider(height: 32, color: AppTheme.surfaceColor),

                  // 5. OPTIONS (Size/Color selector - Placeholder)
                  _buildOptionRow(context, 'Select Size', 'S / M / L / XL'),
                  _buildOptionRow(context, 'Select Color', 'Black Only'),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for size/color selection rows
  Widget _buildOptionRow(BuildContext context, String title, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.mutedColor)),
          Row(
            children: [
              Text(value, style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white)),
              const Icon(Icons.chevron_right, color: AppTheme.mutedColor),
            ],
          ),
        ],
      ),
    );
  }
}