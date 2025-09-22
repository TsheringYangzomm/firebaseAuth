class Product {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] as num).toDouble(),
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
  
  // ADD THIS METHOD:
  factory Product.fromMap(Map<String, dynamic> map) {
  // Handle price conversion from String to double
  double parsePrice(dynamic price) {
    if (price is num) return price.toDouble();
    if (price is String) {
      // Remove dollar sign and commas, then parse
      final cleanPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleanPrice) ?? 0.0;
    }
    return 0.0;
  }

  return Product(
    id: map['id']?.toString() ?? '',
    name: map['name']?.toString() ?? '',
    price: parsePrice(map['price']),
    description: map['description']?.toString() ?? '',
    imageUrl: map['imageUrl']?.toString() ?? '',
  );
}
}