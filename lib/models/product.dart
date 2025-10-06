// lib/models/product.dart

class Product {
  final String id;
  final String name;
  final String imageUrl;
  final String price;
  final bool isLimited;
  final String artist;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.isLimited,
    required this.artist,
  });
}