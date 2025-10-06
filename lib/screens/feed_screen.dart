// lib/screens/feed_screen.dart (FINAL CONSOLIDATED VERSION - Stories Removed & DM Added)

import 'package:flutter/material.dart';

// New imports for local data loading
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../theme/app_theme.dart';
import 'search_screen.dart';
import 'add_post_screen.dart';
import 'post_details_screen.dart';
import 'dm_screen.dart'; // Added for DM functionality

// --- PLACEHOLDER POST MODEL ---
class Post {
  final String id;
  final String username;
  final String userAvatarUrl;
  final String imageUrl;
  final String caption;
  final DateTime timestamp;
  final int likes;
  final int comments;
  final bool isLiked;

  Post({
    required this.id,
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrl,
    required this.caption,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      // Mapping from mock JSON keys
      username: json['userName'] as String,
      userAvatarUrl: json['userAvatarUrl'] as String,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      isLiked: json['isLiked'] as bool,
    );
  }
}
// ------------------------------

// --- UTILITY: Time formatting function ---
String _formatNumber(int n) {
  if (n >= 1000) {
    return '${(n / 1000).toStringAsFixed(1)}K';
  }
  return n.toString();
}

String _timeAgo(DateTime time) {
  final difference = DateTime.now().difference(time);
  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  }
  return 'Just now';
}

// --- SCREEN: FeedsScreen (The main tab content) ---

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<Post> _posts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }
  
  Future<void> _fetchPosts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final String response = await rootBundle.loadString('lib/data/mock_feed_data.json');
      final List<dynamic> data = json.decode(response);
      _posts = data.map((postJson) => Post.fromJson(postJson)).toList();
      
    } catch (e) {
      _error = 'Failed to load local posts. Check pubspec.yaml and JSON format. Error: $e';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crimson Feed',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.mutedColor),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined, color: AppTheme.mutedColor),
            onPressed: () {
              // DM Navigation implemented
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DMScreen(),
                ),
              );
            },
          ),
        ],
      ),
      
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.primaryColor))
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Text('Error: $_error', style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red)),
                  ),
                )
              : _posts.isEmpty
                  ? Center(child: Text('No posts yet.', style: theme.textTheme.bodyLarge))
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      // STORIES REMOVED: itemCount is now just the length of the posts list
                      itemCount: _posts.length,
                      itemBuilder: (context, index) {
                        
                        // STORIES REMOVED: Removed the index == 0 check and MemberStoryReel widget
                        
                        // The post index is now simply 'index'
                        final post = _posts[index];
                        return FeedCard(post: post);
                      },
                    ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddPostScreen(),
            ),
          );
        },
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.edit_note, color: Colors.white, size: 30),
      ),
    );
  }
}

// --- WIDGET FOR INDIVIDUAL POSTS (FEED CARD) ---

class FeedCard extends StatelessWidget {
  final Post post;
  
  const FeedCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // WRAP the entire card in an InkWell for tap detection
    return InkWell(
      onTap: () {
        // NAVIGATE to the PostDetailsScreen, passing the current post object
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PostDetailsScreen(post: post),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppTheme.surfaceColor, width: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. HEADER: Avatar, Username, and Menu Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 8.0, 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: post.username.contains('_Official') ? AppTheme.primaryColor : AppTheme.surfaceColor,
                    // Image is loaded from the assets path specified in the mock data
                    backgroundImage: AssetImage(post.userAvatarUrl),
                    onBackgroundImageError: (exception, stackTrace) {
                      debugPrint('Error loading avatar: $exception');
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.username,
                          style: theme.textTheme.titleSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          _timeAgo(post.timestamp),
                          style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.more_horiz, color: AppTheme.mutedColor),
                ],
              ),
            ),
            
            // 2. CAPTION
            if (post.caption.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  post.caption,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            
            // 3. IMAGE CONTENT
            if (post.imageUrl.isNotEmpty)
              Image.asset(
                post.imageUrl,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: AppTheme.surfaceColor,
                    alignment: Alignment.center,
                    child: const Text('Image Failed to Load', style: TextStyle(color: AppTheme.mutedColor)),
                  );
                },
              ),
              
            // 4. ACTIONS (Like, Comment) and Stats
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LIKE BUTTON
                  Row(
                    children: [
                      Icon(
                        post.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: post.isLiked ? AppTheme.primaryColor : AppTheme.mutedColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_formatNumber(post.likes)} Likes',
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.mutedColor),
                      ),
                    ],
                  ),
                  
                  // COMMENT BUTTON/STATS
                  Row(
                    children: [
                      const Icon(
                        Icons.comment_outlined,
                        color: AppTheme.mutedColor,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_formatNumber(post.comments)} Comments',
                        style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.mutedColor),
                      ),
                    ],
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