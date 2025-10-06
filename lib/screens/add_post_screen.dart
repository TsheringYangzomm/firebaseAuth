// lib/screens/add_post_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Create Post',
          style: theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                // TODO: Implement post submission logic (using ApiService post method)
                Navigator.of(context).pop();
              },
              child: Text(
                'POST',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: theme.textTheme.bodyLarge,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "What's on your mind? Start typing here...",
                        hintStyle: theme.textTheme.bodyLarge?.copyWith(
                          color: AppTheme.mutedColor,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Container(
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: AppTheme.surfaceColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Text(
              'Media Preview Area (Max 4 Photos)',
              style: theme.textTheme.bodyMedium,
            ),
          ),
          
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.surfaceColor, width: 1)),
              color: AppTheme.backgroundColor,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined, color: AppTheme.primaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.videocam_outlined, color: AppTheme.primaryColor),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on_outlined, color: AppTheme.mutedColor),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.public, color: AppTheme.mutedColor, size: 18),
                    label: Text(
                      'Everyone',
                      style: theme.textTheme.bodyMedium,
                    ),
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