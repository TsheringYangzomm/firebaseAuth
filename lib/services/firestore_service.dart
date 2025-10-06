// lib/services/firestore_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
// Import the new Post model
import '../models/post_model.dart'; 
// Import the User model if you have one (or use a placeholder)
// import '../models/user_model.dart'; 

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ---------------------------------------------
  // 1. POSTS (The main content feed)
  // ---------------------------------------------
  
  // Get the main feed of posts (sorted by newest first)
  Stream<List<Post>> getFeedPosts() {
    // Queries the 'posts' collection, ordered by 'timestamp' descending
    return _db
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.id, doc.data())).toList();
    });
  }
  
  // Get posts by a specific user (for the Profile screen)
  Stream<List<Post>> getUserPosts(String userId) {
    return _db
        .collection('posts')
        .where('ownerUid', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.id, doc.data())).toList();
    });
  }

  // Add a new post to the database
  Future<void> addPost(Post post) async {
    // Firestore automatically generates the ID here
    await _db.collection('posts').add(post.toMap());
  }

  // ---------------------------------------------
  // 2. INTERACTIONS (Liking)
  // ---------------------------------------------

  // Simple function to increment a like count
  Future<void> likePost(String postId) async {
    final postRef = _db.collection('posts').doc(postId);
    
    // Uses FieldValue.increment for safe, atomic updates (best practice)
    await postRef.update({'likeCount': FieldValue.increment(1)});
  }
  
  // ---------------------------------------------
  // 3. USERS (Getting user data for profile display)
  // ---------------------------------------------

  // Placeholder for getting user data (you'll implement UserModel later)
  Stream<Map<String, dynamic>> getUserProfile(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return doc.data() ?? {};
      }
      return {};
    });
  }
}