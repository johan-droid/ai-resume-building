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
    ResumeTemplate(id: '1', name: 'Modern', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Modern&font=poppins'),
    ResumeTemplate(id: '2', name: 'Classic', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Classic&font=poppins'),
    ResumeTemplate(id: '3', name: 'Creative', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Creative&font=poppins'),
    ResumeTemplate(id: '4', name: 'Professional', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Pro&font=poppins'),
    ResumeTemplate(id: '5', name: 'Simple', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Simple&font=poppins'),
    ResumeTemplate(id: '6', name: 'Technical', imageUrl: 'https://placehold.co/400x560/EBF4FF/3A506B?text=Tech&font=poppins'),
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
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 templates per row
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.7, // Adjust for template shape
          ),
          itemCount: _templates.length,
          itemBuilder: (context, index) {
            final template = _templates[index];
            return _buildTemplateCard(template);
          },
        ),
      ),
    );
  }

  Widget _buildTemplateCard(ResumeTemplate template) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResumeBuilderScreen(template: template),
          ),
        );
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias, // Ensures the image respects the border radius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                color: Colors.grey.shade200,
                child: Image.network(
                  template.imageUrl,
                  fit: BoxFit.cover,
                  // Loading and error builders for better UX
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                template.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}