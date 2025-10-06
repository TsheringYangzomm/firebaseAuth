// lib/widgets/member_story_reel.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/member.dart';
import '../services/api_service.dart';

class MemberStoryReel extends StatelessWidget {
  const MemberStoryReel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ApiService apiService = ApiService();

    return FutureBuilder<List<Member>>(
      future: apiService.fetchMembers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(strokeWidth: 2, color: AppTheme.mutedColor),
          );
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: 100,
            alignment: Alignment.center,
            child: Text('Failed to load stories.', style: theme.textTheme.bodyMedium),
          );
        }

        final members = snapshot.data!;
        
        return Container(
          height: 100, 
          color: theme.scaffoldBackgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 8.0, 
                  right: index == members.length - 1 ? 16.0 : 8.0, 
                ),
                child: MemberStoryItem(member: member),
              );
            },
          ),
        );
      },
    );
  }
}


class MemberStoryItem extends StatelessWidget {
  final Member member;

  const MemberStoryItem({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          // ... (Styling for the gradient border remains the same)
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: member.hasUnwatchedStory
                ? const LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  )
                : null,
            border: member.hasUnwatchedStory
                ? null
                : Border.all(color: AppTheme.surfaceColor, width: 2),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.scaffoldBackgroundColor,
            ),
            padding: const EdgeInsets.all(2),
            child: CircleAvatar( // <<< THIS WIDGET IS CHANGED
              radius: 26,
              // Load the actual image asset
              backgroundImage: AssetImage(member.avatarUrl), 
              backgroundColor: AppTheme.mutedColor, 
              // Fallback child in case the image fails to load
              child: Image.asset(
                member.avatarUrl,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, color: AppTheme.backgroundColor, size: 30);
                },
              ),
            ),
          ),
        ),
        
        // ... (Rest of the build method remains the same)
      ],
    );
  }
}