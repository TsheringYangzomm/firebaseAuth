// lib/screens/my_page_screen.dart (FINAL VERSION with corrected imports)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
// CRITICAL: Ensure this import points to your actual LoginScreen file.
// Assuming your Login screen is in 'login_screen.dart' in the same directory.
import 'login_screen.dart'; 


class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  // --- LOGOUT NAVIGATION LOGIC ---
  void _handleLogout(BuildContext context) {
    // 1. **TODO**: Implement state management logic here to clear user session (e.g., SharedPreferences, user state reset).
    
    // 2. Navigate to the LoginScreen and clear all previous routes.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        // Assuming your login screen widget is named LoginScreen
        builder: (context) => const LoginScreen(), 
      ),
      (Route<dynamic> route) => false, // This condition clears the entire stack.
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Page', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              // TODO: Navigate to dedicated settings screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- User Profile Header ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Engene_CrimsonFan', style: theme.textTheme.titleLarge),
                      Text('Joined 2023.01.15', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.mutedColor),
                ],
              ),
            ),
            
            const Divider(color: AppTheme.surfaceColor, thickness: 1),

            // --- Membership Section (Weverse-style) ---
            _buildSectionHeader(theme, 'My Membership'),
            _MembershipCard(theme: theme),
            
            const SizedBox(height: 16),
            const Divider(color: AppTheme.surfaceColor, thickness: 8), 

            // --- Activity/Content Section ---
            _buildSectionHeader(theme, 'Activity'),
            _buildListItem(theme, Icons.bookmark_border, 'My Bookmarks'),
            _buildListItem(theme, Icons.add_photo_alternate_outlined, 'My Posts & Comments'),
            _buildListItem(theme, Icons.thumb_up_alt_outlined, 'Liked Content'),
            
            const Divider(color: AppTheme.surfaceColor, thickness: 8), 

            // --- Purchase Section ---
            _buildSectionHeader(theme, 'Purchases & Support'),
            _buildListItem(theme, Icons.credit_card_outlined, 'Order & Payment History'),
            _buildListItem(theme, Icons.confirmation_number_outlined, 'Ticket & Event Status'),
            _buildListItem(theme, Icons.support_agent, 'Help & Customer Service'),
            
            // ------------------------------------------------------------------
            // --- LOGOUT BUTTON TILE ---
            // ------------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                leading: const Icon(Icons.logout, color: Colors.redAccent),
                title: Text(
                  'Logout',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.redAccent),
                onTap: () => _handleLogout(context), // Call the logout handler
              ),
            ),
            // ------------------------------------------------------------------
            
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
  
  // Helper widget for section titles
  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
  
  // Helper widget for list items
  Widget _buildListItem(ThemeData theme, IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      leading: Icon(icon, color: AppTheme.primaryColor, size: 24),
      title: Text(title, style: theme.textTheme.bodyLarge),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.mutedColor),
      onTap: () {},
    );
  }
}

class _MembershipCard extends StatelessWidget {
  final ThemeData theme;
  const _MembershipCard({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ENGENE GLOBAL MEMBERSHIP',
            style: theme.textTheme.titleSmall?.copyWith(color: AppTheme.primaryColor),
          ),
          const SizedBox(height: 4),
          Text(
            'Valid until 2025.12.31',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'View Membership Details >',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}