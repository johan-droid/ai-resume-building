import 'package:flutter/material.dart';
import 'package:rezume_app/main.dart';
import 'package:rezume_app/screens/auth/registration_screen.dart';
import 'package:rezume_app/screens/auth/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool registrationSuccessful;
  
  const LoginScreen({super.key, this.registrationSuccessful = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- 1. Add a Form Key and Controllers ---
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Show success message if coming from registration
    if (widget.registrationSuccessful) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please login with your credentials.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- 2. Create the Login Logic ---
  void _login() {
    // This checks if the form is valid (i.e., fields are not empty)
    if (_formKey.currentState!.validate()) {
      // --- DUMMY AUTHENTICATION ---
      // In a real app, you'd check this against your backend.
      // For now, any 10-digit number and any 6+ char password will work.
      print('Login successful!');

      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        // IMPORTANT: Use your main screen with the bottom nav bar here
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      // If the form is not valid, show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen height
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4FF),

      // 1. This tells the blue body to go up behind the app bar
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        // 2. This makes the app bar itself invisible
        backgroundColor: Colors.transparent,
        elevation: 0,

        // 3. This makes the back arrow WHITE and VISIBLE
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // --- NEW REDESIGNED BODY ---
      body: Stack(
        children: [
          // --- LAYER 1: THE BACKGROUND ---
          Column(
            children: [
              // 1. The blue "Welcome Back" header
              Container(
                height: screenHeight * 0.45,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF007BFF),
                  // This gives it the nice curve
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                // --- REPLACED CHILD: Logo + Spaced Title ---
                child: Padding(
                  // Adjust top padding to make room for the logo
                  padding: const EdgeInsets.only(left: 32.0, top: 90.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. THE LOGO (document icon)
                      Icon(
                        Icons.article_rounded,
                        color: Colors.white.withOpacity(0.9),
                        size: 50,
                      ),

                      // 2. SPACING TO PUSH TEXT DOWN
                      const SizedBox(height: 20),

                      // 3. YOUR TEXT
                      const Text(
                        'Welcome\nBack!!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 3. The light blue icon background
              Expanded(
                child: Container(
                  color: const Color(0xFFF0F8FF),
                ),
              ),
            ],
          ),

          // --- LAYER 2: THE SCROLLABLE LOGIN CARD ---
          SingleChildScrollView(
            child: Padding(
              // Start the card from a bit higher up
              padding: EdgeInsets.only(
                top: screenHeight * 0.35,
                left: 24,
                right: 24,
              ),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey, // Your FormKey
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 4. Rounded Phone Number Field
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone number',
                            prefixIcon: const Icon(Icons.phone_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().length < 10) {
                              return 'Please enter a valid 10-digit number';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // 5. Rounded Password Field
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        // Forgot Password Button
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordScreen()),
                              );
                            },
                            child: const Text('Forgot password?'),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 6. Rounded LOGIN Button
                        ElevatedButton(
                          onPressed: _login, // Your login function
                          child: const Text('LOGIN'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF007BFF),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 7. Styled "Register" Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegistrationScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF007BFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
