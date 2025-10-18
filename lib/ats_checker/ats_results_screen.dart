import 'package:flutter/material.dart';
import 'dart:math';
import 'package:rezume_app/ats_checker/resume_editor_screen.dart';

class AtsResultsScreen extends StatefulWidget {
  const AtsResultsScreen({super.key});

  @override
  State<AtsResultsScreen> createState() => _AtsResultsScreenState();
}

class _AtsResultsScreenState extends State<AtsResultsScreen> {
  // --- 1. State Variables ---
  // These will hold our random data
  int _atsScore = 0;
  String _scoreMessage = '';
  List<Map<String, dynamic>> _suggestions = [];

  // --- 2. Master List of All Possible Suggestions ---
  // THIS IS THE NEW, SMARTER LIST
  final List<Map<String, dynamic>> _allSuggestions = [
    {
      'icon': Icons.trending_up_rounded,
      'title': 'Use Stronger Action Verbs',
      'subtitle': "In your Experience, change 'responsible for' to a strong verb like 'Managed vehicle upkeep' or 'Oversaw daily safety checks'.",
    },
    {
      'icon': Icons.vpn_key_rounded,
      'title': 'Add Job-Specific Keywords',
      'subtitle': "Your 'Driver' resume is missing keywords like 'Route Planning', 'Fleet Management', or 'Safety Compliance'. Add them to your Skills.",
    },
    {
      'icon': Icons.calculate_rounded,
      'title': 'Quantify Your Impact',
      'subtitle': "You did great with 'Improved by 15%'. Do it again! For 'Managed all delivery routes', add a number: 'Managed 12 daily routes'.",
    },
    {
      'icon': Icons.article_rounded,
      'title': 'Tailor Your Job Title',
      'subtitle': "Your title is 'Driver', but the (fake) job ad is for 'Logistics Coordinator'. Change your title to match the job you want.",
    },
    {
      'icon': Icons.spellcheck_rounded,
      'title': 'Fix Potential Typos',
      'subtitle': "We found a potential typo: 'vehicle upkeep'. Did you mean 'vehicle maintenance'? Please review your Experience section.",
    },
    {
      'icon': Icons.format_list_bulleted_rounded,
      'title': 'Use Bullet Points',
      'subtitle': "Your 'Experience' section is a large paragraph. Break it into 3-4 bullet points to make it easier to read quickly.",
    }
  ];

  @override
  void initState() {
    super.initState();
    // This runs the function as soon as the page opens
    _generateFakeAtsData();
  }

  // --- 3. The "AI" Simulation Function ---
  void _generateFakeAtsData() {
    // Generate a random score between 60 and 95
    final random = Random();
    final score = 60 + random.nextInt(36); // 36 = 95 - 60 + 1

    // Pick 3 random, unique suggestions
    final shuffledList = List.of(_allSuggestions)..shuffle(random);
    final selectedSuggestions = shuffledList.take(3).toList();

    // Set the message based on the score
    String message;
    if (score > 85) {
      message = "This is an excellent score! Just a few minor tweaks.";
    } else if (score > 70) {
      message = "This is a good score! Here are some suggestions to make it even better.";
    } else {
      message = "There's room for improvement. Let's fix these key areas.";
    }

    // Update the state to rebuild the UI
    setState(() {
      _atsScore = score;
      _scoreMessage = message;
      _suggestions = selectedSuggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text('Your ATS Score'),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. The Score Card ---
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.blue[50], // Light blue background
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text('YOUR SCORE', style: TextStyle(color: Colors.blue[800])),
                        SizedBox(height: 8),
                        // --- DYNAMIC SCORE ---
                        Text(
                          '$_atsScore%',
                          style: TextStyle(
                            fontSize: 72,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF007BFF),
                          ),
                        ),
                        SizedBox(height: 8),
                        // --- DYNAMIC MESSAGE ---
                        Text(
                          _scoreMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),

              // --- 2. The Suggestions List ---
              Text(
                'AI Suggestions to Improve',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),

              // --- DYNAMIC LIST ---
              ListView.builder(
                itemCount: _suggestions.length,
                shrinkWrap: true, // Important inside a SingleChildScrollView
                physics: NeverScrollableScrollPhysics(), // Let the parent scroll
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  // Use your styled card here
                  return _buildSuggestionCard(
                    icon: suggestion['icon'],
                    title: suggestion['title'],
                    subtitle: suggestion['subtitle'],
                  );
                },
              ),

              SizedBox(height: 24),
              // --- 3. The Edit Button ---
              ElevatedButton(
                onPressed: () {
                  // --- THIS IS THE CHANGE ---
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResumeEditorScreen(
                        // Pass the list of suggestions to the new screen
                        suggestions: _suggestions, 
                      ),
                    ),
                  );
                  // --- END OF CHANGE ---
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Edit My Resume',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 5. Your Suggestion Card Helper ---
  // You probably already have this, just make sure it's here
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