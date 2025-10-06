// lib/widgets/post_card.dart

import 'package:flutter/material.dart';
import '../models/post_model.dart'; // Ensure Post model is imported
import '../models/member_model.dart'; // Ensure Member model is imported (for post.author and post.taggedMembers)
import '../theme/app_theme.dart'; // Assuming you have a theme file

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  // Helper method to build the tagged member display
  Widget _buildTagsSection(BuildContext context) {
    if (post.taggedMembers.isEmpty) {
      return const SizedBox.shrink(); // Show nothing if no one is tagged
    }
    
    // Display the first tagged user and a count if there are more
    final String tagText = post.taggedMembers.length == 1
        ? 'with @${post.taggedMembers.first.username}'
        : 'with @${post.taggedMembers.first.username} and ${post.taggedMembers.length - 1} others';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        children: [
          const Icon(Icons.people_alt_outlined, size: 16, color: AppTheme.mutedColor),
          const SizedBox(width: 4),
          // Using RichText or TextSpan to make it look like part of the post description
          Text(
            tagText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppTheme.primaryColor, // Highlighted text for tags
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      // elevation: 0.5, // Optional: add a slight shadow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Post Header (Avatar, Username, Menu)
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(post.author.profileImageUrl ?? 'https://via.placeholder.com/150'),
            ),
            title: Text(
              post.author.username,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.more_vert),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          ),

          // 2. Tags Section (NEW)
          _buildTagsSection(context), 

          // 3. Post Image
          Image.network(
            post.imageUrl,
            width: double.infinity,
            height: 300,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 300,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              );
            },
          ),
          
          const SizedBox(height: 8),

          // 4. Action Bar (Likes, Comments, Timestamp) - (Adapted from previous fix)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.favorite_outline,
                  size: 18,
                  color: AppTheme.mutedColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.likes} Likes',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.mutedColor,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.mode_comment_outlined,
                  size: 18,
                  color: AppTheme.mutedColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '${post.commentsCount} Comments', 
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.mutedColor,
                  ),
                ),

                const Spacer(),
                
                Text(
                  '${DateTime.now().difference(post.timestamp).inHours}h', // Simple difference
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.mutedColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // 5. Caption
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: RichText(
              text: TextSpan(
                style: theme.textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: '${post.author.username} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: post.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}