import 'package:flutter/material.dart';
import 'package:rezume_app/screens/onboarding/user_profession_screen.dart'; // We will create this next

class UserExperienceScreen extends StatelessWidget {
  const UserExperienceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8), // A light background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back button
        centerTitle: true,
        title: const Text(
          "A Quick Question",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lightbulb_outline, size: 80, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                "Have you created a resume before?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "This helps us personalize your journey.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 50),
              _buildOptionCard(
                context: context,
                icon: Icons.person_add_alt_1_rounded,
                title: "I'm a Beginner",
                subtitle: "First time making a resume",
              ),
              const SizedBox(height: 20),
              _buildOptionCard(
                context: context,
                icon: Icons.upgrade_rounded,
                title: "I'm Experienced",
                subtitle: "I've made resumes before",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next onboarding screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UserProfessionScreen()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}