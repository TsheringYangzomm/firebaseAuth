import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // Ensure you have this import

// --- Mock Data Structure for DMs ---
class Conversation {
  final String id;
  final String userName;
  final String lastMessage;
  final String timeAgo;
  final String userAvatarUrl;
  final bool unread;

  Conversation({
    required this.id,
    required this.userName,
    required this.lastMessage,
    required this.timeAgo,
    required this.userAvatarUrl,
    this.unread = false,
  });
}

// --- Mock Data List ---
final List<Conversation> mockConversations = [
  Conversation(
    id: 'c1',
    userName: 'JUNGWON_Official',
    lastMessage: 'I think it looks better than the previous one! 😉',
    timeAgo: '1m',
    userAvatarUrl: 'assets/avatars/jungwon.jpeg',
    unread: true,
  ),
  Conversation(
    id: 'c2',
    userName: 'Jake_Official',
    lastMessage: 'The new MV teaser dropped! Check it out.',
    timeAgo: '1h',
    userAvatarUrl: 'assets/avatars/jake.webp',
  ),
  Conversation(
    id: 'c3',
    userName: 'EngeneForever',
    lastMessage: 'Are you going to the concert next week?',
    timeAgo: '2h',
    userAvatarUrl: 'assets/avatars/sunghoon.jpeg',
  ),
  Conversation(
    id: 'c4',
    userName: 'Jay_Official',
    lastMessage: 'Thanks for the message! 🙏',
    timeAgo: '1d',
    userAvatarUrl: 'assets/avatars/jay_fixed.jpeg',
  ),
];


class DMScreen extends StatelessWidget {
  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Direct Messages',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppTheme.primaryColor, // Use the Crimson App theme color
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined, color: AppTheme.mutedColor),
            onPressed: () {
              // TODO: Implement New Message functionality
            },
          ),
        ],
      ),
      
      body: mockConversations.isEmpty
          ? Center(
              child: Text(
                'No new messages.',
                style: theme.textTheme.bodyLarge?.copyWith(color: AppTheme.mutedColor),
              ),
            )
          : ListView.builder(
              itemCount: mockConversations.length,
              itemBuilder: (context, index) {
                final convo = mockConversations[index];
                return _DMListTile(convo: convo);
              },
            ),
    );
  }
}

// --- Helper Widget for individual conversation items ---
class _DMListTile extends StatelessWidget {
  final Conversation convo;

  const _DMListTile({required this.convo});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ListTile(
      onTap: () {
        // TODO: Implement navigation to the actual chat screen
        debugPrint('Navigating to chat with ${convo.userName}');
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      
      // Avatar
      leading: CircleAvatar(
        radius: 28,
        backgroundColor: convo.userName.contains('_Official') ? AppTheme.primaryColor : AppTheme.surfaceColor, 
        backgroundImage: AssetImage(convo.userAvatarUrl),
        onBackgroundImageError: (exception, stackTrace) {
          debugPrint('Error loading avatar: $exception');
        },
      ),
      
      // User Name and Last Message
      title: Text(
        convo.userName,
        style: theme.textTheme.titleMedium?.copyWith(
          color: Colors.white,
          fontWeight: convo.unread ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      subtitle: Text(
        convo.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: convo.unread ? Colors.white : AppTheme.mutedColor,
          fontWeight: convo.unread ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      
      // Time and Unread indicator
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            convo.timeAgo,
            style: theme.textTheme.bodySmall?.copyWith(
              color: convo.unread ? AppTheme.primaryColor : AppTheme.mutedColor,
            ),
          ),
          if (convo.unread)
            const Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: AppTheme.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}