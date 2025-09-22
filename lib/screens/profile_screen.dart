import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/auth_page.dart';
import '../services/user_profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserProfileService _profileService = UserProfileService();
  Map<String, dynamic> _userData = {};
  String? _profileImagePath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await _profileService.getUserProfile();
    final user = _profileService.currentUser;
    
    setState(() {
      _userData = userData;
      _profileImagePath = userData['profileImage'] as String?;
      _isLoading = false;
    });
  }

  Future<void> _uploadProfilePicture() async {
    // Simulate image upload
    setState(() {
      _profileImagePath = 'assets/placeholder_profile.png';
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Profile picture updated!'),
        backgroundColor: Colors.lightBlue[700],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _profileService.currentUser;
    final displayName = _userData['name'] as String? ?? user?.displayName ?? 'User';
    final email = user?.email ?? _userData['email'] as String? ?? 'No email';

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("👤 Profile"),
          backgroundColor: Colors.lightBlue[700],
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("👤 Profile"),
        backgroundColor: Colors.lightBlue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.lightBlue[100],
                    child: _profileImagePath != null
                        ? const Icon(Icons.person, size: 40, color: Colors.lightBlue)
                        : const Icon(Icons.person, size: 40, color: Colors.lightBlue),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[700],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo, size: 20, color: Colors.white),
                      onPressed: _uploadProfilePicture,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                displayName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue[800],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              
              // Profile Options
              _buildProfileOption(Icons.person, "Edit Profile", () {}),
              _buildProfileOption(Icons.settings, "Settings", () {}),
              _buildProfileOption(Icons.history, "Order History", () {}),
              _buildProfileOption(Icons.favorite, "Favorites", () {}),
              _buildProfileOption(Icons.help, "Help & Support", () {}),
              
              const Spacer(),
              
              // Logout Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _profileService.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AuthPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.lightBlue[700]),
        title: Text(title, style: TextStyle(color: Colors.lightBlue[800])),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.lightBlue[700]),
        onTap: onTap,
      ),
    );
  }
}