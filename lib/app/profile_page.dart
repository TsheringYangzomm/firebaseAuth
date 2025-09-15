import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          // Profile avatar
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 3),
            ),
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 20),
          // User name
          Text(
            user?.displayName ?? "User",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // User email
          Text(
            user?.email ?? "No email",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          // Email verification status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (user?.emailVerified ?? false)
                  ? Colors.green[50]
                  : Colors.orange[50],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: (user?.emailVerified ?? false)
                    ? Colors.green
                    : Colors.orange,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (user?.emailVerified ?? false)
                      ? Icons.verified
                      : Icons.warning,
                  size: 16,
                  color: (user?.emailVerified ?? false)
                      ? Colors.green
                      : Colors.orange,
                ),
                const SizedBox(width: 5),
                Text(
                  (user?.emailVerified ?? false)
                      ? "Email verified"
                      : "Email not verified",
                  style: TextStyle(
                    color: (user?.emailVerified ?? false)
                        ? Colors.green[800]
                        : Colors.orange[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          
          // Account info card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Information",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildInfoRow(
                    icon: Icons.email,
                    label: "Email",
                    value: user?.email ?? "Not provided",
                  ),
                  const Divider(),
                  _buildInfoRow(
                    icon: Icons.person,
                    label: "User ID",
                    value: user != null 
                        ? "${user.uid.substring(0, 12)}..." 
                        : "Unknown",
                  ),
                  const Divider(),
                  _buildInfoRow(
                    icon: Icons.calendar_today,
                    label: "Account created",
                    value: user?.metadata.creationTime != null
                        ? _formatDate(user!.metadata.creationTime!)
                        : "Unknown",
                  ),
                  const Divider(),
                  _buildInfoRow(
                    icon: Icons.login,
                    label: "Last sign-in",
                    value: user?.metadata.lastSignInTime != null
                        ? _formatDate(user!.metadata.lastSignInTime!)
                        : "Unknown",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Actions
          const Text(
            "Account Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          _buildActionButton(
            icon: Icons.verified_user,
            label: "Verify Email",
            onPressed: () {
              // Add email verification logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Verification email sent"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            color: Colors.blue,
          ),
          _buildActionButton(
            icon: Icons.lock_reset,
            label: "Change Password",
            onPressed: () {
              // Add change password logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password reset email sent"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            color: Colors.orange,
          ),
          _buildActionButton(
            icon: Icons.delete,
            label: "Delete Account",
            onPressed: () {
              // Add delete account logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Account deletion requested"),
                  backgroundColor: Colors.red,
                ),
              );
            },
            color: Colors.red,
          ),
          // Add some extra space at the bottom to ensure scrolling works
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}