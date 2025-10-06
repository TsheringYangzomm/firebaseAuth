// lib/screens/main_screen.dart (CORRECTED)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'feed_screen.dart';
import 'shop_screen.dart'; 
import 'my_page_screen.dart'; 
import 'media_screen.dart'; 
// <<< CRITICAL NEW IMPORT: Add the LiveScreen here >>>
import 'live_screen.dart'; 


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // The 5 Required Screens - ORDER MUST MATCH BottomNavigationBarItems BELOW
  static const List<Widget> _widgetOptions = <Widget>[
    FeedsScreen(), // Index 0: Feed (Home Icon)
    MediaScreen(), // Index 1: Media/Videos (Video Icon)
    ShopScreen(), // Index 2: Shop (Bag Icon)
    MyPageScreen(), // Index 3: My Page/Profile (Person Icon)

    // Index 4: Live (Mic Icon) - FIX IS HERE: Use the actual LiveScreen!
    LiveScreen(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor, 
          border: Border(top: BorderSide(color: AppTheme.mutedColor, width: 0.1)),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video_outlined), // Changed to video icon
              activeIcon: Icon(Icons.ondemand_video),
              label: 'Media',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'Shop',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'My Page',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mic_none), // Live/Concert icon
              activeIcon: Icon(Icons.mic),
              label: 'Live',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: AppTheme.surfaceColor,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: AppTheme.mutedColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false, 
          showSelectedLabels: false, 
          elevation: 0,
          selectedIconTheme: const IconThemeData(size: 26),
          unselectedIconTheme: const IconThemeData(size: 26),
        ),
      ),
    );
  }
}