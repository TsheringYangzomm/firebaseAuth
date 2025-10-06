// lib/screens/main_navigation_screen.dart

import 'package:flutter/material.dart';

// NOTE: We rely on these imports, ensure these files exist or are placeholders
import 'feed_screen.dart'; 
import 'member_gallery_screen.dart'; 
import 'add_post_screen.dart'; 
import 'profile_screen.dart'; 
import 'alerts_screen.dart'; // Correctly used for the 5th tab

// Removed PostDetailScreen import as it's not a primary navigation tab

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key}); 

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // CRITICAL FIX: The list must contain exactly 5 screens to match the 5 navigation bar items.
  final List<Widget> _screens = const [
    FeedsScreen(),               // Tab 0: Home Feed
    MemberGalleryScreen(),     // Tab 1: Member Gallery
    AddPostScreen(),           // Tab 2: Create Post (often centered)
    AlertsScreen(),            // Tab 3: Alerts/Notifications
    ProfileScreen(),           // Tab 4: User Profile ('My Page')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  BottomNavigationBarItem _buildIcon(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // CRITICAL FIX: Ensure index access is within bounds (0 to 4)
      body: _screens[_selectedIndex], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          _buildIcon(Icons.home_filled, 'Feed'),
          _buildIcon(Icons.people_alt_rounded, 'Members'), 
          _buildIcon(Icons.add_box_rounded, 'Post'), 
          // Re-ordered the screens/icons to put 'Alerts' before 'My Page' (a common pattern)
          _buildIcon(Icons.notifications_rounded, 'Alerts'), 
          _buildIcon(Icons.account_circle, 'My Page'),
        ],
      ),
    );
  }
}