// lib/profile/resume_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:rezume_app/models/dummy_candidates.dart';

class ResumeDetailScreen extends StatelessWidget {
  final Candidate candidate;

  const ResumeDetailScreen({super.key, required this.candidate});

  // --- Dummy "Send Email" function ---
  void _sendEmail(BuildContext context, String status) {
    // In a real app, this would trigger a backend call to send an email.
    print('Sending ${status.toLowerCase()} email to ${candidate.email}');
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Candidate has been ${status.toLowerCase()}!'),
        backgroundColor: status == 'Accepted' ? Colors.green : Colors.red,
      ),
    );
    
    // Go back to the list after action
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // --- ADD THIS LINE ---
    final Color _primaryColor = Colors.indigo.shade600;
    // --- END OF ADDITION ---

    return Scaffold(
      appBar: AppBar(
        title: Text(candidate.name),
        backgroundColor: _primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: _primaryColor.withOpacity(0.1),
                    child: Text(candidate.name.substring(0, 1), style: TextStyle(fontSize: 32, color: _primaryColor)),
                  ),
                  SizedBox(height: 12),
                  Text(candidate.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(candidate.jobProfile, style: TextStyle(fontSize: 18, color: Colors.grey[600])),
                  Text('${candidate.location} | ${candidate.email}'),
                ],
              ),
            ),
            SizedBox(height: 24),
            
            // --- Sections ---
            _buildSectionTitle('Qualification', _primaryColor),
            _buildSectionContent(candidate.qualification),
            
            _buildSectionTitle('Experience', _primaryColor),
            _buildSectionContent('${candidate.experience} years'),
            
            _buildSectionTitle('Skills', _primaryColor),
            _buildSectionContent(candidate.skills.join(', ')), // Display skills as a comma-separated string
            
            _buildSectionTitle('Achievements', _primaryColor),
            ...candidate.achievements.map((ach) => _buildListItem(ach)).toList(), // Display achievements as a bulleted list
            
            SizedBox(height: 40),

            // --- Action Buttons ---
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.check_circle_outline),
                    label: Text('ACCEPT'),
                    onPressed: () => _sendEmail(context, 'Accepted'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.cancel_outlined),
                    label: Text('REJECT'),
                    onPressed: () => _sendEmail(context, 'Rejected'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets for Resume Sections ---
  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(title.toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
    );
  }
  
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Text(content, style: TextStyle(fontSize: 16)),
    );
  }
  
  Widget _buildListItem(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(content, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
