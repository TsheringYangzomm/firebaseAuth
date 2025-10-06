class Post {
  final String id;
  // Properties used in FeedCard
  final String username; // Replaces authorName
  final String userAvatarUrl; // Replaces authorAvatarUrl
  final String caption; // Replaces content
  final DateTime timestamp; // Must be DateTime
  final bool isLiked; // New field required

  final String imageUrl; 
  final int likes;
  final int comments;
  
  const Post({
    required this.id,
    required this.username,
    required this.userAvatarUrl,
    required this.caption,
    required this.timestamp,
    this.imageUrl = '',
    this.likes = 0,
    this.comments = 0,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      // Map API names (if different) to model properties
      username: json['authorName'] as String, 
      userAvatarUrl: json['authorAvatarUrl'] as String,
      caption: json['content'] as String, 
      timestamp: DateTime.parse(json['timestamp'] as String), // Parse string to DateTime
      imageUrl: json['imageUrl'] as String? ?? '',
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }
}