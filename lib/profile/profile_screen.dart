import 'package:flutter/material.dart';
import 'package:rezume_app/screens/auth/login_screen.dart'; // This path is correct as is
import 'package:rezume_app/profile/help_center_screen.dart'; // Corrected path

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Your Profile"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView(
        children: [
          // User info header
          UserAccountsDrawerHeader(
            accountName: const Text("John Doe", style: TextStyle(fontSize: 20)),
            accountEmail: const Text("johndoe@example.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("J", style: TextStyle(fontSize: 40.0, color: Colors.blueAccent)),
            ),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          // Menu options
          _buildProfileOption(icon: Icons.person_outline, title: "Edit Profile", onTap: () {}),
          _buildProfileOption(icon: Icons.article_outlined, title: "My Saved Resumes", onTap: () {}),
          _buildProfileOption(icon: Icons.settings_outlined, title: "Settings", onTap: () {}),
          _buildProfileOption(
            icon: Icons.help_outline,
            title: "Help Center",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
              );
            },
          ),
          const Divider(),
          _buildProfileOption(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              // Navigate to login and clear all previous screens
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}