import 'package:flutter/material.dart';
import 'package:rezume_app/models/resume_template_model.dart';

class ResumeBuilderScreen extends StatelessWidget {
  final ResumeTemplate template;

  const ResumeBuilderScreen({Key? key, required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Building with '${template.name}'"),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          // This Expanded widget will hold the chat messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Example of a message from the AI assistant
                _buildChatMessage(
                  isUser: false,
                  message: "Great choice! Let's start with your personal details. What is your full name?",
                ),
              ],
            ),
          ),
          // This container will hold the text input field
          Container(
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
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: () {
                    // Logic to send the message
                  },
                ),
              ],
            ),
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