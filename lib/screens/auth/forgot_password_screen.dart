// lib/screens/auth/forgot_password_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // --- 1. State Variables for OTP flow ---
  bool _isOtpSent = false;
  Timer? _timer;
  int _start = 120; // 2 minutes in seconds
  bool _canResend = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }
  
  // --- 2. Timer Logic ---
  void _startTimer() {
    _canResend = false;
    _start = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  // --- 3. "Send Code" Logic ---
  void _sendCode() {
    if (_formKey.currentState!.validate()) {
      print('Sending OTP to ${_phoneController.text}');
      setState(() {
        _isOtpSent = true;
      });
      _startTimer();
    }
  }

  // --- 4. "Verify OTP" Logic ---
  void _verifyOtp() {
    if (_otpController.text.length == 6) {
      _timer?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified! (Demo)')),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  // --- 5. "Change Number" Logic ---
  void _changeNumber() {
    _timer?.cancel();
    setState(() {
      _isOtpSent = false;
      _canResend = false;
      _otpController.clear();
    });
  }

  String get _timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // This uses the same UI structure as your Login screen
    return Scaffold(
      extendBodyBehindAppBar: true, // Lets the body go behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. Blue Header ---
            Container(
              width: double.infinity,
              height: 300, // Adjust as needed
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Color(0xFF007BFF), // Your app's main blue
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60), // For status bar + app bar
                  Text(
                    _isOtpSent ? 'Enter Code' : 'Reset Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // --- 2. White Card with Form ---
            Padding(
              padding: const EdgeInsets.all(24.0),
              // We add a negative margin to make it overlap the blue
              child: Transform.translate(
                offset: const Offset(0, -80), // Pulls the card up
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: _isOtpSent ? _buildOtpScreen() : _buildPhoneScreen(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI for entering the phone number ---
  Widget _buildPhoneScreen() {
    return Column(
      children: [
        Text(
          'Enter your phone number below. We will send you a verification code to reset your password.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _phoneController,
          decoration: InputDecoration(
            labelText: 'Phone number',
            prefixIcon: Icon(Icons.phone),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.phone,
          validator: (v) => v!.length < 10 ? 'Enter a valid number' : null,
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _sendCode,
          child: Text('SEND CODE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ],
    );
  }

  // --- UI for entering the OTP ---
  Widget _buildOtpScreen() {
    return Column(
      children: [
        Text(
          'Enter the 6-digit code sent to\n${_phoneController.text}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: _otpController,
          decoration: InputDecoration(
            labelText: 'OTP',
            prefixIcon: Icon(Icons.password_rounded),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType: TextInputType.number,
          maxLength: 6,
          validator: (v) => v!.length < 6 ? 'Enter a 6-digit OTP' : null,
        ),
        const SizedBox(height: 16),
        
        // Timer and Resend button
        _canResend
          ? TextButton(
              onPressed: _sendCode, 
              child: Text('Resend OTP', style: TextStyle(fontSize: 16))
            )
          : Text(
              'Resend OTP in $_timerText', 
              style: TextStyle(color: Colors.grey, fontSize: 16)
            ),
        
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _verifyOtp,
          child: Text('VERIFY'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF007BFF),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        TextButton(
          onPressed: _changeNumber,
          child: Text('Change Number'),
        ),
      ],
    );
  }
}