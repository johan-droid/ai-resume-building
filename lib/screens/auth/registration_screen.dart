import 'package:flutter/material.dart';
import 'package:rezume_app/screens/onboarding/user_experience_screen.dart';
import 'package:rezume_app/widgets/custom_button.dart';
import 'package:rezume_app/widgets/custom_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _selectedGender; // To track selected gender

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
        title: const Text("REZOOM", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              child: Column(
                children: [
                  Image.asset('assets/images/logo.png', width: 100), // Ensure you have this logo
                  const SizedBox(height: 10),
                  const Text("User Details", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
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
                    const CustomTextField(labelText: "Full name:"),
                    const SizedBox(height: 20),
                    const CustomTextField(labelText: "Phone number:"),
                    const SizedBox(height: 20),
                    // State Dropdown (example)
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'State:',
                        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0)),
                      ),
                      items: <String>['Odisha', 'West Bengal', 'Maharashtra', 'Delhi']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle state selection
                      },
                      hint: const Text('Select State'),
                    ),
                    const SizedBox(height: 20),
                    const CustomTextField(labelText: "Set Password:", isPassword: true),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Gender:", style: TextStyle(color: Color(0xFF3A506B), fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 10),
                    // Gender Selection
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _genderSelector('male', Icons.male, "Male"),
                        _genderSelector('female', Icons.female, "Female"),
                      ],
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "SUBMIT",
                      onPressed: () {
                        // Add registration logic here
                        print("Submit button pressed");
                        // Navigate to the first onboarding screen
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => UserExperienceScreen()),
                                (Route<dynamic> route) => false,
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

  Widget _genderSelector(String gender, IconData icon, String label) {
    bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: isSelected ? Colors.blueAccent : Colors.grey.shade300,
            child: Icon(icon, size: 40, color: isSelected ? Colors.white : Colors.grey.shade700),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(color: isSelected ? Colors.blueAccent : Colors.black, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}