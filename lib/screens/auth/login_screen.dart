import 'package:flutter/material.dart';
import 'package:rezume_app/main.dart';
import 'package:rezume_app/screens/auth/registration_screen.dart';
import 'package:rezume_app/screens/auth/forgot_password_screen.dart';
import 'package:rezume_app/widgets/custom_button.dart';
import 'package:rezume_app/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // For the background icon pattern
    final List<IconData> backgroundIcons = [
      Icons.construction, Icons.cleaning_services, Icons.plumbing,
      Icons.delivery_dining, Icons.engineering, Icons.carpenter,
      Icons.format_paint, Icons.agriculture, Icons.local_shipping,
      Icons.handyman, Icons.electrical_services, Icons.build,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4FF),
      
      // --- THIS IS THE FIX ---
      
      // 1. This tells the blue body to go up behind the app bar
      extendBodyBehindAppBar: true, 
      
      appBar: AppBar(
        // 2. This makes the app bar itself invisible
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        
        // 3. This makes the back arrow WHITE and VISIBLE
        iconTheme: IconThemeData(color: Colors.white), 
      ),
      // --- END OF FIX ---
      
      body: Stack(
        children: [
          // Background icon pattern
          IgnorePointer(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
              ),
              itemCount: 100, // Just a large number to fill the screen
              itemBuilder: (context, index) {
                return Icon(
                  backgroundIcons[index % backgroundIcons.length],
                  color: Colors.blue.withOpacity(0.08),
                );
              },
            ),
          ),
          // Main UI
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Upper blue curved part
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: const BoxDecoration(
                      color: Color(0xFF007BFF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.0, bottom: 40.0),
                        child: Text(
                          "Welcome\nBack!!",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Login Form Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Transform.translate(
                      offset: const Offset(0, -80),
                      child: Container(
                        padding: const EdgeInsets.all(25.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD).withOpacity(0.95),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const CustomTextField(labelText: "Phone number:"),
                            const SizedBox(height: 20),
                            const CustomTextField(labelText: "Password:", isPassword: true),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: Color(0xFF007BFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: "LOGIN",
                              onPressed: () {
                                // Add login logic here
                                print("Login button pressed");
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const MainScreen()), // Changed this line
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Register button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                          );
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}