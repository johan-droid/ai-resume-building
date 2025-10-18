// lib/screens/splash_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
// Make sure this import path is correct for your project!
import 'package:rezume_app/screens/language_selection_screen.dart'; 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// Add 'with SingleTickerProviderStateMixin' for the animation
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
      
  // --- 1. Animation Variables ---
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // --- 2. Initialize the Animation ---
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // This gives a nice "pop"
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Start the animation
    _controller.forward();

    // --- 3. Your Existing Navigation Timer ---
    // This will run *after* the animation has had time to play
    Timer(
      const Duration(seconds: 3), // 3-second delay
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          // Change this to your login screen if the user is already logged in
          builder: (context) => const LanguageSelectionScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // 4. Clean up the controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The same dark blue background from your screenshot
      backgroundColor: const Color(0xFF2c3e50), 
      body: Center(
        // --- 5. Apply the Animations ---
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Your Icon
                Icon(
                  Icons.article_rounded,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                // Your App Name
                Text(
                  'REZOOM',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}