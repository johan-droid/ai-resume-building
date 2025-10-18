import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // This holds the currently selected language. 'English' is the default.
  String _selectedLanguage = 'English';

  // --- ADD THIS MAP for the header ---
  final Map<String, String> _localizedHeader = {
    'English': 'How to Get Started',
    'Hindi': 'कैसे शुरू करें',
    'Odia': 'କିପରି ଆରମ୍ଭ କରିବେ',
  };

  // --- ADD THIS MAP for the subtitle ---
  final Map<String, String> _localizedVideoSubtitle = {
    'English': 'Showing tutorial in: English',
    'Hindi': 'ट्यूटोरियल हिंदी में दिखाया जा रहा है',
    'Odia': 'ଟ୍ୟୁଟୋରିଆଲ୍ ଓଡିଆରେ ଦେଖାଯାଉଛି',
  };

  // --- ADD THIS MAP for the feature cards ---
  final Map<String, List<Map<String, dynamic>>> _localizedCards = {
    'English': [
      {
        'icon': Icons.article_rounded,
        'title': 'Step 1: Choose a Template',
        'subtitle': 'Pick a professional template that fits your style.',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'title': 'Step 2: Fill in Details with AI',
        'subtitle': 'Use our AI assistant to help you write details.',
      },
      {
        'icon': Icons.download_for_offline_rounded,
        'title': 'Step 3: Download your Resume',
        'subtitle': 'Download your completed resume as a PDF.',
      },
    ],
    'Hindi': [
      {
        'icon': Icons.article_rounded,
        'title': 'चरण 1: एक टेम्पलेट चुनें',
        'subtitle': 'एक पेशेवर टेम्पलेट चुनें जो आपकी शैली के अनुरूप हो।',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'title': 'चरण 2: AI से विवरण भरें',
        'subtitle':
            'विवरण लिखने में सहायता के लिए हमारे AI सहायक का उपयोग करें।',
      },
      {
        'icon': Icons.download_for_offline_rounded,
        'title': 'चरण 3: अपना रिज्यूमे डाउनलोड करें',
        'subtitle':
            'अपना पूरा किया गया रिज्यूमे एक PDF के रूप में डाउनलोड करें।',
      },
    ],
    'Odia': [
      {
        'icon': Icons.article_rounded,
        'title': 'ପର୍ଯ୍ୟାୟ ୧: ଏକ ଟେମ୍ପ୍ଲେଟ୍ ବାଛନ୍ତୁ',
        'subtitle':
            'ଆପଣଙ୍କ ଶୈଳୀ ସହିତ ମେଳ ଖାଉଥିବା ଏକ ପେଶାଦାର ଟେମ୍ପ୍ଲେଟ୍ ବାଛନ୍ତୁ।',
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'title': 'ପର୍ଯ୍ୟାୟ ୨: AI ସହିତ ବିବରଣୀ ଭରନ୍ତୁ',
        'subtitle': 'ବିବରଣୀ ଲେଖିବାରେ ସାହାଯ୍ୟ ପାଇଁ ଆମର AI ସହାୟକ ବ୍ୟବହାର କରନ୍ତୁ।',
      },
      {
        'icon': Icons.download_for_offline_rounded,
        'title': 'ପର୍ଯ୍ୟାୟ ୩: ଆପଣଙ୍କ ରିଜ୍ୟୁମ୍ ଡାଉନଲୋଡ୍ କରନ୍ତୁ',
        'subtitle': 'ଆପଣଙ୍କ ସମ୍ପୂର୍ଣ୍ଣ ରିଜ୍ୟୁମ୍ PDF ଭାବରେ ଡାଉନଲୋଡ୍ କରନ୍ତୁ।',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // In your build method...
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. Welcome Header (NOW DYNAMIC) ---
              Text(
                _localizedHeader[_selectedLanguage] ?? 'How to Get Started',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // --- 2. Language Selector (No change) ---
              Center(
                child: SegmentedButton<String>(
                  style: SegmentedButton.styleFrom(
                    backgroundColor: Colors.blue[50],
                    selectedBackgroundColor: const Color(0xFF007BFF),
                    selectedForegroundColor: Colors.white,
                  ),
                  segments: const [
                    ButtonSegment<String>(
                      value: 'English',
                      label: Text('English'),
                    ),
                    ButtonSegment<String>(
                      value: 'Hindi',
                      label: Text('हिंदी'),
                    ),
                    ButtonSegment<String>(
                      value: 'Odia',
                      label: Text('ଓଡ଼ିଆ'),
                    ),
                  ],
                  selected: {_selectedLanguage},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      // This updates the selected language
                      _selectedLanguage = newSelection.first;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),

              // --- 3. Video Player Placeholder (No change) ---
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    color: Colors.white.withOpacity(0.8),
                    size: 60,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                // --- Video Subtitle (NOW DYNAMIC) ---
                child: Text(
                  _localizedVideoSubtitle[_selectedLanguage] ??
                      'Showing tutorial...',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

              const SizedBox(height: 24),

              // --- 4. Features Section (NOW DYNAMIC) ---
              // This dynamically builds the 3 cards
              Column(
                children: _localizedCards[_selectedLanguage]!.map((cardData) {
                  return _buildFeatureCard(
                    icon: cardData['icon'],
                    title: cardData['title'],
                    subtitle: cardData['subtitle'],
                    onTap: () {
                      // You can add navigation logic here if needed
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for building the new feature cards
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    // These colors match your app's theme
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
          leading: Icon(
            icon,
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
        ),
      ),
    );
  }
}
