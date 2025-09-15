import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'profile_page.dart';
import 'more_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;

  late final List<Widget> _pages;
  final List<String> _pageTitles = [
    "Home",
    "Profile",
    "More",
  ];

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContentPage(
        onProfileTap: () => _onItemTapped(1),
        onMoreTap: () => _onItemTapped(2),
      ),
      const ProfilePage(),
      const MorePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signed out successfully"),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "More",
          ),
        ],
      ),
    );
  }
}

class HomeContentPage extends StatelessWidget {
  const HomeContentPage({
    super.key,
    required this.onProfileTap,
    required this.onMoreTap,
  });

  final VoidCallback onProfileTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back, ${user?.displayName ?? 'User'}!",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "You've successfully signed in to your account.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 15),
                Text(
                  "Email: ${user?.email ?? 'No email'}",
                  style: const TextStyle(fontSize: 14),
                ),
                if (user?.emailVerified ?? false) ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.verified, color: Colors.green[700], size: 16),
                      const SizedBox(width: 5),
                      Text(
                        "Email verified",
                        style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange[700], size: 16),
                      const SizedBox(width: 5),
                      Text(
                        "Email not verified",
                        style: TextStyle(
                          color: Colors.orange[700],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Quick actions
          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: [
              _buildActionCard(
                icon: Icons.person,
                title: "Profile",
                color: Colors.purple,
                onTap: onProfileTap,
              ),
              _buildActionCard(
                icon: Icons.settings,
                title: "Settings",
                color: Colors.orange,
                onTap: () {
                  // TODO: Navigate to Settings page or show a dialog
                },
              ),
              _buildActionCard(
                icon: Icons.security,
                title: "Privacy",
                color: Colors.green,
                onTap: () {
                  // TODO: Navigate to Privacy page
                },
              ),
              _buildActionCard(
                icon: Icons.help,
                title: "Help",
                color: Colors.red,
                onTap: onMoreTap,
              ),
            ],
          ),
          const SizedBox(height: 30),
          
          // Recent activity
          const Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildActivityItem(
            icon: Icons.login,
            title: "Signed in",
            subtitle: "Just now",
            color: Colors.green,
          ),
          _buildActivityItem(
            icon: Icons.person_add,
            title: "Account created",
            subtitle: user?.metadata.creationTime?.toString().split(' ')[0] ?? "Unknown",
            color: Colors.blue,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
  
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}