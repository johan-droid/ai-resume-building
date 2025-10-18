// lib/ats_checker/resume_editor_screen.dart

import 'package:flutter/material.dart';

class ResumeEditorScreen extends StatefulWidget {
  // We will pass the list of suggestions from the previous screen
  final List<Map<String, dynamic>> suggestions;

  const ResumeEditorScreen({
    super.key,
    required this.suggestions,
  });

  @override
  State<ResumeEditorScreen> createState() => _ResumeEditorScreenState();
}

class _ResumeEditorScreenState extends State<ResumeEditorScreen> {
  // --- DUMMY DATA CONTROLLERS ---
  // These will hold the user's data and make it editable
  // We use the data from your "blue-collar" chat flow
  late TextEditingController _nameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _skillsController;
  late TextEditingController _experienceController;

  @override
  void initState() {
    super.initState();
    // Load the (dummy) resume data into the text fields
    _nameController = TextEditingController(text: 'John Doe');
    _jobTitleController = TextEditingController(text: 'Driver');
    _skillsController = TextEditingController(
      text: 'Defensive Driving, Vehicle Maintenance, Logistics, GPS Navigation',
    );
    _experienceController = TextEditingController(
      text: 'Managed all delivery routes for XYZ Logistics. responsible for vehicle upkeep and safety checks. Improved on-time delivery by 15%.',
    );
  }

  @override
  void dispose() {
    // Clean up the controllers
    _nameController.dispose();
    _jobTitleController.dispose();
    _skillsController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Resume'),
        actions: [
          // A "Save" button
          IconButton(
            icon: Icon(Icons.save_rounded),
            onPressed: () {
              // TODO: Add logic to save the new text
              // For now, just go back
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. THE EDITABLE RESUME ---
            Text(
              'Your Details (Editable)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildEditField(controller: _nameController, label: 'Full Name'),
            _buildEditField(controller: _jobTitleController, label: 'Job Title'),
            _buildEditField(
              controller: _skillsController,
              label: 'Your Skills',
              maxLines: 3,
            ),
            _buildEditField(
              controller: _experienceController,
              label: 'Your Experience',
              maxLines: 5,
            ),
            
            Divider(height: 40, thickness: 1),

            // --- 2. THE AI SUGGESTIONS ---
            Text(
              'AI Suggestions to Improve',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ListView.builder(
              itemCount: widget.suggestions.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final suggestion = widget.suggestions[index];
                return _buildSuggestionCard(
                  icon: suggestion['icon'],
                  title: suggestion['title'],
                  subtitle: suggestion['subtitle'],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the text fields
  Widget _buildEditField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF007BFF), width: 2),
          ),
        ),
      ),
    );
  }

  // --- Copy this from your ATS Score Screen ---
  Widget _buildSuggestionCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 1.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: Icon(icon, color: Color(0xFF007BFF), size: 28),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }
}