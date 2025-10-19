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
  // --- 1. Add Form Key and Controllers ---
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _selectedGender = '';

  // --- ADD THESE NEW VARIABLES ---
  double _passwordStrength = 0;
  String _strengthText = '';
  Color _strengthColor = Colors.grey;
  // --- END OF NEW VARIABLES ---

  @override
  void initState() {
    super.initState();
    // --- ADD THIS LISTENER ---
    _passwordController.addListener(() {
      _checkPasswordStrength(_passwordController.text);
    });
    // --- END OF LISTENER ---
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  
  // --- 2. Create a helper for the labels with stars ---
  Widget _buildMandatoryLabel(String title) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
        children: const <TextSpan>[
          TextSpan(text: ' *', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
  
  // --- 3. Add Password Strength Checking Logic ---
  void _checkPasswordStrength(String password) {
    double strength = 0;
    String text = 'Weak';
    Color color = Colors.red;

    if (password.isEmpty) {
      strength = 0;
      text = '';
      color = Colors.grey;
    } else if (password.length < 6) {
      strength = 0.25;
      text = 'Too short';
      color = Colors.red;
    } else {
      strength = 0.25; // Base for length > 6
      if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.25; // Has uppercase
      if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.25; // Has numbers
      if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.25; // Has special char
    }

    if (strength >= 1.0) {
      text = 'Very Strong';
      color = Colors.green;
    } else if (strength >= 0.75) {
      text = 'Strong';
      color = Colors.lightGreen;
    } else if (strength >= 0.5) {
      text = 'Medium';
      color = Colors.orange;
    }

    setState(() {
      _passwordStrength = strength;
      _strengthText = text;
      _strengthColor = color;
    });
  }

  // --- 4. Create the Submit Logic ---
  void _register() {
    // This checks if all fields are filled and valid
    if (_formKey.currentState!.validate()) {
      // Also check if a gender has been selected
      if (_selectedGender.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a gender')),
        );
        return; // Stop if gender is not selected
      }

      print('Registration successful!');
      
      // Navigate to the main screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all mandatory fields')),
      );
    }
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Use the new label helper ---
                      _buildMandatoryLabel('Full name:'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        validator: (v) => v!.isEmpty ? 'Name cannot be empty' : null,
                      ),
                      const SizedBox(height: 16),
                      
                      _buildMandatoryLabel('Phone number:'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (v) => v!.length < 10 ? 'Enter a valid number' : null,
                      ),
                      const SizedBox(height: 16),

                      _buildMandatoryLabel('Set Password:'),
                      const SizedBox(height: 8),
                      // --- REPLACE YOUR TextFormField WITH THIS COLUMN ---
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            ),
                            obscureText: true,
                            validator: (v) => v!.length < 6 ? 'Password is too short' : null,
                          ),
                          const SizedBox(height: 8),

                          // --- THIS IS THE NEW STRENGTH BAR ---
                          if (_passwordController.text.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LinearProgressIndicator(
                                  value: _passwordStrength,
                                  backgroundColor: Colors.grey[300],
                                  color: _strengthColor,
                                  minHeight: 6,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _strengthText,
                                  style: TextStyle(color: _strengthColor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                        ],
                      ),
                      // --- END OF REPLACEMENT ---
                      const SizedBox(height: 16),
                      
                      _buildMandatoryLabel('Confirm Password:'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        ),
                        obscureText: true,
                        validator: (v) {
                          if (v != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      _buildMandatoryLabel('Gender:'),
                    const SizedBox(height: 16),

                    // 2. The Row of new buttons
                    Row(
                      // This will space the 3 buttons out nicely
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                      children: [
                        // --- Male Button (No change) ---
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

                        // --- Female Button (No change) ---
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

                        // --- THIS IS THE CORRECTED 'OTHER' BUTTON ---
                        _buildGenderOption(
                          iconPath: 'assets/images/other_avatar.png', // Use your new image path
                          label: 'Other',
                          isSelected: _selectedGender == 'Other',
                          onTap: () {
                            setState(() {
                              _selectedGender = 'Other';
                            });
                          },
                        ),
                      ],
                    ),

                      const SizedBox(height: 30),
                      
                      // --- Update the SUBMIT button ---
                      CustomButton(
                        text: "SUBMIT",
                        onPressed: _register, // <-- Use the new function
                      ),
                      const SizedBox(height: 16),
                      Center(child: Text('* Mandatory', style: TextStyle(color: Colors.red, fontSize: 12))),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for building the gender buttons
  Widget _buildGenderOption({
    String? iconPath, // Make nullable
    IconData? iconData, // Add this
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    // These are your existing colors
    final Color selectedColor = Color(0xFF007BFF);
    final Color unselectedBgColor = Colors.grey[200]!;
    final Color selectedBgColor = selectedColor.withOpacity(0.15);
    final Color unselectedTextColor = Colors.grey[600]!;

    // --- This new logic decides which icon to show ---
    Widget iconWidget;
    if (iconPath != null) {
      // Use Image.asset if iconPath is provided
      iconWidget = Image.asset(
        iconPath,
        width: 45,
        height: 45,
        // Remove 'color' tinting if your images are multi-colored
      );
    } else if (iconData != null) {
      // Use Icon if iconData is provided
      iconWidget = Icon(
        iconData,
        size: 45,
        color: isSelected ? selectedColor : unselectedTextColor,
      );
    } else {
      // Fallback for safety
      iconWidget = SizedBox(width: 45, height: 45);
    }
    // --- End of new logic ---

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40, // Your existing circle size
            backgroundColor: isSelected ? selectedBgColor : unselectedBgColor,
            child: iconWidget, // Use the new dynamic widget here
          ),
          SizedBox(height: 8),
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
