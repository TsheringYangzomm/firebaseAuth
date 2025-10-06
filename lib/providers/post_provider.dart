import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../screens/feed_screen.dart'; // Import to access your Post model

class PostProvider with ChangeNotifier {
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _error;

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  PostProvider() {
    fetchPosts();
  }

  // 1. Fetch posts from the local JSON asset (similar to what was in FeedsScreen)
  Future<void> fetchPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Note: This relies on 'lib/data/mock_feed_data.json' being present and correct
      final String response = await rootBundle.loadString('lib/data/mock_feed_data.json');
      final List<dynamic> data = json.decode(response);
      _posts = data.map((postJson) => Post.fromJson(postJson)).toList();
    } catch (e) {
      _error = 'Failed to load posts from Provider: $e';
      _posts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 2. The core logic for liking/unliking a post
  void toggleLike(String postId) {
    final postIndex = _posts.indexWhere((post) => post.id == postId);

    if (postIndex != -1) {
      final post = _posts[postIndex];
      // Create a new Post object with updated values
      final updatedPost = Post(
        id: post.id,
        username: post.username,
        userAvatarUrl: post.userAvatarUrl,
        imageUrl: post.imageUrl,
        caption: post.caption,
        timestamp: post.timestamp,
        // If liked, decrease count; otherwise, increase
        likes: post.isLiked ? post.likes - 1 : post.likes + 1,
        comments: post.comments,
        // Toggle the liked status
        isLiked: !post.isLiked, 
      );

      // Replace the old post with the new updated post
      _posts[postIndex] = updatedPost;

      // Notify all consumers (widgets) that the data has changed
      notifyListeners(); 

      // In a real app, you would make an API call here:
      // ApiService().sendLike(postId);
    }
  }
}