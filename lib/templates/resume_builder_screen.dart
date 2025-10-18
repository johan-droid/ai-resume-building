import 'package:flutter/material.dart';
import 'package:rezume_app/models/resume_template_model.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

class ResumeBuilderScreen extends StatefulWidget {
  final ResumeTemplate template;
  // --- ADD THIS ---
  final String templateName;

  const ResumeBuilderScreen({
    super.key, 
    required this.template,
    required this.templateName, // <-- Make it required
  });
  // --- END OF CHANGE ---

  @override
  State<ResumeBuilderScreen> createState() => _ResumeBuilderScreenState();
}

class _ResumeBuilderScreenState extends State<ResumeBuilderScreen> {
  // 3. Defines the entire conversation flow
  final List<Map<String, String>> _questionFlow = [
    {'key': 'fullName', 'question': 'Welcome! Let\'s build your job profile. What is your full name?'},
    {'key': 'phone', 'question': 'Got it. What is your 10-digit mobile number?'},
    {'key': 'city', 'question': 'Which city do you live in? (Example: Mumbai, Rourkela, Delhi)'},
    {'key': 'jobType', 'question': 'What kind of job are you looking for? (Example: Driver, Electrician, Plumber, Cook, Security Guard)'},
    {'key': 'experience', 'question': 'How many years of experience do you have in this job? (Type "0" if you are a fresher)'},
    {'key': 'qualification', 'question': 'What is your highest qualification? (Example: 8th Pass, 10th Pass, 12th Pass, ITI, Diploma)'},
    {'key': 'skills', 'question': 'What are your main work skills? (Example: Driving, Welding, Tally, Spoken English, Cooking)'},
    {'key': 'availability', 'question': 'How soon can you join a new job? (Example: Immediately, in 1 week, in 1 month)'},
  ];

  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  int _currentQuestionIndex = 0;
  final Map<String, String> _resumeDetails = {};

  // --- ADD THIS VARIABLE ---
  bool _isConversationComplete = false;

  @override
  void initState() {
    super.initState();
    _askQuestion();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  // This function adds the next bot question to the chat
  void _askQuestion() {
    if (_currentQuestionIndex < _questionFlow.length) {
      // If there are more questions, add the next one
      setState(() {
        _messages.add(ChatMessage(
          text: _questionFlow[_currentQuestionIndex]['question']!,
          isUser: false,
        ));
      });
    } else {
      // If the conversation is over
      setState(() {
        _messages.add(ChatMessage(
          text: 'Great! Your profile is complete. We will start finding the best jobs for you. Thank you.',
          isUser: false,
        ));
        
        // --- THIS IS THE CHANGE ---
        _isConversationComplete = true; // This will show the new button
        // --- END OF CHANGE ---
      });
      // Now you can save the _resumeDetails map to your database or state manager
      print('Final Job Profile Details: $_resumeDetails');
      
      // You could navigate away after a delay:
      // Future.delayed(Duration(seconds: 3), () => Navigator.pop(context));
    }
  }

  void _sendMessage() {
    // --- ADD THIS LINE ---
    if (_isConversationComplete) return; // Don't do anything if chat is over
    // --- END OF CHANGE ---

    String userInput = _textController.text.trim();
    if (userInput.isEmpty) return;

    // Add user message to chat
    setState(() {
      _messages.add(ChatMessage(text: userInput, isUser: true));
    });

    // Store the answer
    if (_currentQuestionIndex < _questionFlow.length) {
      String key = _questionFlow[_currentQuestionIndex]['key']!;
      _resumeDetails[key] = userInput;
      _currentQuestionIndex++;
    }

    // Clear the text field
    _textController.clear();

    // Ask the next question after a short delay
    Future.delayed(const Duration(milliseconds: 500), () {
      _askQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Building with '${widget.templateName}'"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // 1. Your chat message list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: _messages.map((message) => _buildChatMessage(
                isUser: message.isUser,
                message: message.text,
              )).toList(),
            ),
          ),
          
          // --- THIS IS THE CHANGE ---
          
          // 2. Conditionally show the "Generate" button
          if (_isConversationComplete)
            _buildGenerateButton(),

          // 3. Conditionally show the text input bar
          if (!_isConversationComplete)
            _buildChatInput(),
            
          // --- END OF CHANGE ---
        ],
      ),
    );
  }

  // --- ADD THIS ENTIRE NEW METHOD ---
  Widget _buildGenerateButton() {
    return Padding(
      // Add padding so it's not stuck to the bottom
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        children: [
          ElevatedButton.icon(
            icon: Icon(Icons.description_rounded, size: 20),
            label: Text('Generate Resume (with Typst)'),
            onPressed: () {
              // --- This is the dummy action ---
              // In a real app, this would send your _resumeDetails
              // map to your backend for Typst processing.
              
              print('--- DUMMY DATA FOR TYPST ---');
              print(_resumeDetails);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Generating your multilingual resume...'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF007BFF), // Your app's theme color
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              textStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 8),
          // This adds the text you wanted
          Text(
            'Uses Google Translate for multilingual support.',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          )
        ],
      ),
    );
  }

  // Helper method to build the chat input field
  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "Type your answer...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
              onSubmitted: (text) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blueAccent),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  // Helper widget to build a chat bubble
  Widget _buildChatMessage({required bool isUser, required String message}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          message,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}