import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
// Note: You need the Post model here, so we will use the local placeholder structure
import 'feed_screen.dart'; // Import to access the Post model placeholder

class PostDetailsScreen extends StatelessWidget {
  final Post post;

  const PostDetailsScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(post.username),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display Post Image (if available)
            if (post.imageUrl.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Image.asset(
                  post.imageUrl,
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: AppTheme.surfaceColor,
                      alignment: Alignment.center,
                      child: const Text('Image Failed to Load in Detail', style: TextStyle(color: AppTheme.mutedColor)),
                    );
                  },
                ),
              ),

            // Display Caption
            Text(
              post.caption,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            
            // Post Stats
            Row(
              children: [
                Icon(Icons.favorite, color: AppTheme.primaryColor, size: 18),
                const SizedBox(width: 4),
                Text('${post.likes} Likes', style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor)),
                const SizedBox(width: 16),
                Icon(Icons.comment, color: AppTheme.mutedColor, size: 18),
                const SizedBox(width: 4),
                Text('${post.comments} Comments', style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor)),
              ],
            ),
            const SizedBox(height: 32),

            // Placeholder for comments section
            Text('Comments Section (WIP)', style: theme.textTheme.titleSmall?.copyWith(color: AppTheme.primaryColor)),
            // Add more detail widgets here later
          ],
        ),
      ),
    );
  }
}