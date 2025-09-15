import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Settings & More",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Manage your app preferences and account settings",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 30),
          
          // App Settings
          const Text(
            "App Settings",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.notifications,
                  title: "Notifications",
                  subtitle: "Manage your notifications",
                  trailing: Switch(value: true, onChanged: (value) {}),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.lock,
                  title: "Privacy & Security",
                  subtitle: "Manage your privacy settings",
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.palette,
                  title: "Appearance",
                  subtitle: "Change theme and layout",
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.language,
                  title: "Language",
                  subtitle: "English (US)",
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Account Section
          const Text(
            "Account",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.help,
                  title: "Help & Support",
                  subtitle: "Get help with your account",
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.description,
                  title: "Terms & Policies",
                  subtitle: "View our terms and conditions",
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.security,
                  title: "Data & Privacy",
                  subtitle: "Manage your data preferences",
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // App Info
          const Text(
            "About App",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                _buildSettingsItem(
                  icon: Icons.info,
                  title: "App Version",
                  subtitle: "1.0.0",
                  trailing: const SizedBox(),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.update,
                  title: "Check for Updates",
                  subtitle: "Latest version installed",
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(height: 1),
                _buildSettingsItem(
                  icon: Icons.star,
                  title: "Rate App",
                  subtitle: "Share your experience",
                  trailing: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // User Info Section
          const Text(
            "User Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, size: 20, color: Colors.blue),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "User ID",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user != null 
                                ? "${user.uid.substring(0, 10)}..." 
                                : "Unknown",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.email, size: 20, color: Colors.blue),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Email Status",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.emailVerified ?? false ? "Verified" : "Not Verified",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: user?.emailVerified ?? false ? Colors.green : Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.blue),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Member Since",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user?.metadata.creationTime != null
                                  ? _formatDate(user!.metadata.creationTime!)
                                  : "Unknown",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          // Sign Out Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Signed out successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.logout, size: 20),
              label: const Text("Sign Out"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Add some extra space at the bottom to ensure scrolling works
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      trailing: trailing,
      onTap: () {},
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}