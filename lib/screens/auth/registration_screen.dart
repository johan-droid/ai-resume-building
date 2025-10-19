import 'package:flutter/material.dart';
import 'package:rezume_app/main.dart';
import 'package:rezume_app/widgets/custom_button.dart';
import 'package:rezume_app/widgets/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedGender = ''; // To track selected gender

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF007BFF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text("REZOOM",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Upper blue section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0xFF007BFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: const Column(
                children: [
                  Icon(Icons.description, size: 100, color: Colors.white),
                  SizedBox(height: 10),
                  Text("User Details",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            // Registration Form
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: "Full name:",
                      controller: _nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Phone number:",
                      controller: _phoneController,
                    ),

                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Set Password:",
                      controller: _passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      labelText: "Confirm Password:",
                      controller: _confirmPasswordController,
                      isPassword: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // 1. "Gender:" Label
                    const Text(
                      'Gender:',
                      // Make sure this style matches your other labels (like "Full name:")
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2. The Row of new buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // --- Male Button ---
                        _buildGenderOption(
                          iconPath: 'assets/images/male_avatar.png',
                          label: 'Male',
                          isSelected: _selectedGender == 'Male',
                          onTap: () {
                            setState(() {
                              _selectedGender = 'Male';
                            });
                          },
                        ),

                        // --- Female Button ---
                        _buildGenderOption(
                          iconPath: 'assets/images/female_avatar.png',
                          label: 'Female',
                          isSelected: _selectedGender == 'Female',
                          onTap: () {
                            setState(() {
                              _selectedGender = 'Female';
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 24), // Add spacing before your "SUBMIT" button
                    CustomButton(
                      text: "SUBMIT",
                      onPressed: () {
                        // Add registration logic here
                        print("Submit button pressed");
                        // Navigate to the main screen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ADD THIS ENTIRE HELPER METHOD
  Widget _buildGenderOption({
    required String iconPath,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // --- Define your colors ---
    // This is the blue from your "SUBMIT" button
    const Color selectedColor = Color(0xFF007BFF);
    // This is the light grey background from your screenshot
    final Color unselectedBgColor = Colors.grey[200]!;
    // This will be the background color for the selected item
    final Color selectedBgColor = selectedColor.withOpacity(0.15);
    // This is the text color for the unselected item
    final Color unselectedTextColor = Colors.grey[600]!;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // This is the circular background
          CircleAvatar(
            radius: 40, // Sets the circle size (80px diameter)
            backgroundColor: isSelected ? selectedBgColor : unselectedBgColor,
            child: Image.asset(
              iconPath,
              width: 45, // Adjust the image size as needed
              height: 45, // Adjust the image size as needed

              // --- IMPORTANT ---
              // If your images are single-color (like black), you can tint them.
              // If they are multi-color (like a real avatar), KEEP THIS LINE COMMENTED OUT.
              // color: isSelected ? selectedColor : unselectedTextColor,
            ),
          ),
          const SizedBox(height: 8),

          // This is the "Male" / "Female" text
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? selectedColor : unselectedTextColor,
            ),
          )
        ],
      ),
    );
  }
}
