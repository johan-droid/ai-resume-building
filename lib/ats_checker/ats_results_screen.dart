import 'package:flutter/material.dart';

class AtsResultsScreen extends StatelessWidget {
  const AtsResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Your ATS Score"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Score Display Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text("YOUR SCORE", style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 10),
                    // Dummy score display
                    Text("78%", style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                    SizedBox(height: 10),
                    Text(
                      "This is a good score! Here are some suggestions from our AI to make it even better.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Improvement Suggestions
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("AI Suggestions to Improve", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            _buildSuggestionCard(
              icon: Icons.spellcheck,
              title: "Add Action Verbs",
              description: "Replace passive phrases like 'responsible for' with strong action verbs like 'Managed', 'Led', or 'Developed'.",
            ),
            const SizedBox(height: 12),
            _buildSuggestionCard(
              icon: Icons.format_list_numbered,
              title: "Quantify Achievements",
              description: "Instead of 'Improved efficiency', use numbers: 'Improved efficiency by 15% in the first quarter'.",
            ),
            const SizedBox(height: 12),
            _buildSuggestionCard(
              icon: Icons.vpn_key,
              title: "Include Keywords",
              description: "Your resume is missing keywords like 'Project Management' and 'Logistics' found in the job description.",
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text("Edit My Resume", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Navigate to an editing screen (to be built)
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 24, color: Colors.blueAccent),
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