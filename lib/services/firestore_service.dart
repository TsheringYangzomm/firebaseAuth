import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get all products
  Stream<List<Product>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromMap(doc.id, doc.data())).toList();
    });
  }

  // Get single product by ID
  Future<Product?> getProductById(String id) async {
    final doc = await _db.collection('products').doc(id).get();
    if (doc.exists) {
      return Product.fromMap(doc.id, doc.data()!);
    }
    return null;
  }
}
