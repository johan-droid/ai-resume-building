import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How to Get Started",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Placeholder for the video section
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.play_circle_fill, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 24),
            // Step-by-step guide
            _buildStepCard(
              icon: Icons.edit_document,
              title: "Step 1: Choose a Template",
              description: "Pick a professional template that fits your industry and style.",
            ),
            const SizedBox(height: 16),
            _buildStepCard(
              icon: Icons.auto_awesome,
              title: "Step 2: Fill in Details with AI",
              description: "Use our AI assistant to help you write your resume details.",
            ),
            const SizedBox(height: 16),
            _buildStepCard(
              icon: Icons.cloud_download,
              title: "Step 3: Download your Resume",
              description: "Download your completed resume as a professional PDF.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepCard({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}