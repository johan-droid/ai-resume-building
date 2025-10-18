import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rezume_app/ats_checker/ats_results_screen.dart'; // Corrected path

class UploadResumeScreen extends StatefulWidget {
  const UploadResumeScreen({super.key});

  @override
  State<UploadResumeScreen> createState() => _UploadResumeScreenState();
}

class _UploadResumeScreenState extends State<UploadResumeScreen> {
  String? _fileName;
  bool _isLoading = false;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  void _checkAtsScore() {
    if (_fileName == null) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate network call to backend for ATS analysis
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AtsResultsScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Check ATS Score"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                "Upload Your Resume",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Get an instant analysis of how well your resume scores with Applicant Tracking Systems.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              // File upload button
              OutlinedButton.icon(
                icon: const Icon(Icons.attach_file),
                label: Text(_fileName ?? "Choose File (.pdf, .doc)"),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _pickFile,
              ),
              const SizedBox(height: 40),
              // Check score button
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _fileName != null ? _checkAtsScore : null, // Button is disabled until file is chosen
                      child: const Text("Check My Score", style: TextStyle(color: Colors.white)),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}