import 'package:flutter/material.dart';
import 'package:rezume_app/widgets/custom_button.dart';
import 'package:rezume_app/widgets/custom_textfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendResetCode() {
    if (_formKey.currentState!.validate()) {
      print('Sending reset code to: ${_phoneController.text}');
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification code sent!')),
      );
      
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<IconData> backgroundIcons = [
      Icons.construction, Icons.cleaning_services, Icons.plumbing,
      Icons.delivery_dining, Icons.engineering, Icons.carpenter,
      Icons.format_paint, Icons.agriculture, Icons.local_shipping,
      Icons.handyman, Icons.electrical_services, Icons.build,
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4FF),
      body: Stack(
        children: [
          // Background icon pattern
          IgnorePointer(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
              ),
              itemCount: 100,
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
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 10,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30.0, bottom: 40.0),
                            child: Text(
                              "Reset\nPassword",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Card
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              const Text(
                                'Enter your phone number below. We will send you a verification code to reset your password.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16, 
                                  color: Color(0xFF3A506B),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 25),
                              CustomTextField(
                                labelText: "Phone number:",
                                controller: _phoneController,
                                validator: (value) {
                                  if (value == null || value.trim().length < 10) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 30),
                              CustomButton(
                                text: "SEND CODE",
                                onPressed: _sendResetCode,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}