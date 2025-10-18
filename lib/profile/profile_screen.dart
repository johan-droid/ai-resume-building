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
      body: Column(
        children: [
          // --- 1. NEW REDESIGNED HEADER ---
          // This replaces the blue box
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50, // Made the circle a bit larger
                  backgroundColor: Color(0xFF007BFF).withOpacity(0.1),
                  child: Text(
                    'J',
                    style: TextStyle(fontSize: 48, color: Color(0xFF007BFF)),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'John Doe', // Placeholder Name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '+91 98765 43210', // Placeholder Phone Number
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // --- 2. REDESIGNED BUTTONS ---
          // This uses the cleaner Material 3 list tiles
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 30.0),
              children: [
                _buildProfileOption(
                  icon: Icons.person_outline_rounded,
                  title: 'Edit Profile',
                  onTap: () {
                    // Your navigation logic
                  },
                ),
                _buildProfileOption(
                  icon: Icons.article_outlined,
                  title: 'My Saved Resumes',
                  onTap: () {
                    // Your navigation logic
                  },
                ),
                _buildProfileOption(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    // Your navigation logic
                  },
                ),
                _buildProfileOption(
                  icon: Icons.help_outline_rounded,
                  title: 'Help Center',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
                    );
                  },
                ),
                SizedBox(height: 20), // Spacer
                _buildProfileOption(
                  icon: Icons.logout_rounded,
                  title: 'Logout',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  isLogout: true, // This will make it red
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for building the new Material 3-style list tiles
  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false, // To make the logout button red
  }) {
    final Color color = isLogout ? Colors.red.shade700 : Color(0xFF0056b3);
    // This light blue background will match your app's theme
    final Color bgColor = isLogout ? Colors.red.shade50 : Color(0xFFf0f8ff); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: bgColor, // Set a subtle background color
        leading: Icon(icon, color: color, size: 24),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
            fontSize: 16,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: color,
        ),
      ),
    );
  }
}