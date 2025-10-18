// lib/profile/saved_resumes_screen.dart

import 'package:flutter/material.dart';

class SavedResumesScreen extends StatelessWidget {
  const SavedResumesScreen({super.key});

  // --- 1. Your Dummy Resume Data ---
  final List<Map<String, String>> dummyResumes = const [
    {
      'title': 'Driver Profile (Odia)',
      'subtitle': 'Last edited: Oct 18, 2025',
    },
    {
      'title': 'Software Engineer (English)',
      'subtitle': 'Last edited: Oct 15, 2025',
    },
    {
      'title': 'Cook / Chef (Hindi)',
      'subtitle': 'Last edited: Oct 12, 2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Saved Resumes'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyResumes.length,
        itemBuilder: (context, index) {
          final resume = dummyResumes[index];
          return _buildResumeCard(
            title: resume['title']!,
            subtitle: resume['subtitle']!,
            onTap: () {
              // TODO: Navigate to the editor for this resume
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${resume['title']}...')),
              );
            },
          );
        },
      ),
    );
  }

  // --- 2. Helper Method for the Card Style ---
  // This matches your profile screen's style
  Widget _buildResumeCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    const Color color = Color(0xFF0056b3); // Dark blue
    final Color bgColor = Colors.blue[50]!; // Light blue

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Card(
        elevation: 1.5,
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          // We use a resume icon for all of them
          leading: const Icon(
            Icons.article_rounded,
            color: color,
            size: 28,
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: color,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: color.withOpacity(0.7)),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: color,
          ),
        ),
      ),
    );
  }
}
