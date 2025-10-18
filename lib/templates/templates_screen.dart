import 'package:flutter/material.dart';
import 'package:rezume_app/models/resume_template_model.dart';
import 'package:rezume_app/templates/resume_builder_screen.dart'; // Corrected path

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({super.key});

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  // Dummy data for our templates
  final List<ResumeTemplate> _templates = [
    ResumeTemplate(
        id: '1',
        name: 'Modern',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Modern&font=poppins'),
    ResumeTemplate(
        id: '2',
        name: 'Classic',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Classic&font=poppins'),
    ResumeTemplate(
        id: '3',
        name: 'Creative',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Creative&font=poppins'),
    ResumeTemplate(
        id: '4',
        name: 'Professional',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Pro&font=poppins'),
    ResumeTemplate(
        id: '5',
        name: 'Simple',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Simple&font=poppins'),
    ResumeTemplate(
        id: '6',
        name: 'Technical',
        imageUrl:
            'https://placehold.co/400x560/EBF4FF/3A506B?text=Tech&font=poppins'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Choose a Template"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Two columns
        padding: const EdgeInsets.all(16.0),
        mainAxisSpacing: 16.0, // Spacing between rows
        crossAxisSpacing: 16.0, // Spacing between columns
        children: [
          _buildTemplateCard(
            icon: Icons.article_outlined,
            title: 'Modern',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[0],
                    templateName: 'Modern',
                  ),
                ),
              );
            },
          ),
          _buildTemplateCard(
            icon: Icons.school_outlined,
            title: 'Classic',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[1],
                    templateName: 'Classic',
                  ),
                ),
              );
            },
          ),
          _buildTemplateCard(
            icon: Icons.brush_outlined,
            title: 'Creative',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[2],
                    templateName: 'Creative',
                  ),
                ),
              );
            },
          ),
          _buildTemplateCard(
            icon: Icons.business_center_outlined,
            title: 'Professional',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[3],
                    templateName: 'Professional',
                  ),
                ),
              );
            },
          ),
          _buildTemplateCard(
            icon: Icons.code_outlined,
            title: 'Technical',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[5],
                    templateName: 'Technical',
                  ),
                ),
              );
            },
          ),
          _buildTemplateCard(
            icon: Icons.person_outline,
            title: 'Simple',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResumeBuilderScreen(
                    template: _templates[4],
                    templateName: 'Simple',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method for building the new template cards
  Widget _buildTemplateCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    // These are the same colors from your profile screen
    const Color color = Color(0xFF0056b3); // Dark blue
    const Color bgColor = Color(0xFFf0f8ff); // Light blue

    return Card(
      elevation: 2.0, // Adds a subtle shadow
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        // Makes the whole card tappable
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50, // Large, clear icon
                color: color,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
