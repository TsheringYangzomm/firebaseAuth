// lib/screens/post_detail_screen.dart (ENHANCED VERSION)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// --- 1. DUMMY DATA ---

class Comment {
  final String user;
  final String text;
  final String timestamp;

  const Comment({
    required this.user,
    required this.text,
    required this.timestamp,
  });
}

const List<Comment> dummyComments = [
  Comment(user: 'Engene_Forever', text: 'This is the best photo from the shoot! The lighting is incredible.', timestamp: '5m'),
  Comment(user: 'CrimsonArchivist', text: 'Confirmed: This era is going to be legendary! 🐺', timestamp: '10m'),
  Comment(user: 'SunooFan7', text: 'Sunoo looks absolutely radiant here! ❤️', timestamp: '15m'),
  Comment(user: 'JayIsKing', text: 'Can\'t wait for the new comeback trailer! 🔥', timestamp: '20m'),
  Comment(user: 'HeeseungBias', text: 'Their visuals are unmatched.', timestamp: '25m'),
  Comment(user: 'NiKiDance', text: 'I wish I could dance like Ni-ki!', timestamp: '30m'),
  Comment(user: 'JakeLover', text: 'Sim Jaeyun nation rise up!', timestamp: '35m'),
];

// --- 2. MAIN SCREEN WIDGET ---

class PostDetailScreen extends StatelessWidget {
  // Using placeholders for a full post structure (like from the FeedScreen)
  final String username;
  final String imageUrl;
  final String caption;
  final int likes;
  final String timestamp;

  const PostDetailScreen({
    super.key,
    this.username = 'ENHYPEN_Official',
    this.imageUrl = 'images/enhypen_1.jpg', // Default to a known working asset path
    this.caption = 'Hope you enjoy the new updates! We love you, ENGENE!',
    this.likes = 2500,
    this.timestamp = '2 hours ago',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Details',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),

      // Use a Column for the main layout: Scrollable Content + Fixed Input Bar
      body: Column(
        children: [
          // Scrollable Post Content (Post + Comments)
          Expanded(
            child: ListView(
              children: [
                // A. THE ORIGINAL POST (Reusing the Feed Card structure)
                _buildPostHeader(theme, username, timestamp),
                _buildPostImage(imageUrl),
                _buildPostActions(theme, likes, caption),
                
                const Divider(color: AppTheme.surfaceColor, height: 20, thickness: 1),

                // B. COMMENT SECTION HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Comments (${dummyComments.length})',
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),

                // C. COMMENT LIST
                ...dummyComments.map((comment) => CommentTile(comment: comment)).toList(),
                
                const SizedBox(height: 10), // Padding below the last comment
              ],
            ),
          ),

          // D. COMMENT INPUT BAR (Fixed at the bottom)
          _buildCommentInputBar(theme),
        ],
      ),
    );
  }

  // --- WIDGET BUILDER FUNCTIONS ---

  Widget _buildPostHeader(ThemeData theme, String username, String timestamp) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.secondaryColor,
            child: Icon(Icons.person, color: AppTheme.textColor, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            username,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            timestamp,
            style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImage(String imageUrl) {
    return ClipRRect(
      child: Image.asset(
        'assets/$imageUrl', // The correct path structure for local assets
        width: double.infinity,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 250,
            color: AppTheme.secondaryColor,
            alignment: Alignment.center,
            child: const Text('Image failed to load', style: TextStyle(color: AppTheme.mutedColor)),
          );
        },
      ),
    );
  }

  Widget _buildPostActions(ThemeData theme, int likes, String caption) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Action Row (Like, Comment, Share)
          Row(
            children: [
              IconButton(icon: const Icon(Icons.favorite, color: AppTheme.primaryColor), onPressed: () {}),
              Text('$likes Likes', style: theme.textTheme.bodyMedium),
              const SizedBox(width: 20),
              IconButton(icon: const Icon(Icons.mode_comment_outlined, color: AppTheme.mutedColor), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 8),

          // Caption
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyLarge,
              children: <TextSpan>[
                TextSpan(
                  text: '$username: ',
                  style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border(top: BorderSide(color: AppTheme.secondaryColor, width: 0.5)),
      ),
      child: SafeArea( // Ensures content stays above system navigation bars
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryColor,
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Add a comment...',
                  hintStyle: TextStyle(color: AppTheme.mutedColor.withOpacity(0.7)),
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppTheme.backgroundColor,
                ),
                style: theme.textTheme.bodyMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppTheme.primaryColor),
              onPressed: () {
                // TODO: Implement sending comment functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. COMMENT TILE WIDGET ---

class CommentTile extends StatelessWidget {
  final Comment comment;

  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundColor: AppTheme.mutedColor,
            child: Icon(Icons.person, size: 16, color: AppTheme.textColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: '${comment.user}: ',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textColor,
                        ),
                      ),
                      TextSpan(
                        text: comment.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  comment.timestamp,
                  style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          
          // Optional: Like/Action button for the comment
          IconButton(
            icon: const Icon(Icons.favorite_border, size: 16, color: AppTheme.mutedColor),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}