import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rezume_app/app/localization/app_localizations.dart';
import 'package:rezume_app/providers/locale_provider.dart';
import 'package:rezume_app/screens/auth/login_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _selectLanguage(BuildContext context, String languageCode) {
    // Update the locale using the provider
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(Locale(languageCode));

    // **FIX 1: Use push instead of pushReplacement to allow going back**
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Helper function for easier translation access
    String t(String key) {
      return AppLocalizations.of(context)!.translate(key);
    }

    return Scaffold(
      backgroundColor: const Color(0xFF3A506B),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A506B), Color(0xFF0B132B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 120),
                const SizedBox(height: 20),
                // **FIX 2: Use translated strings instead of hardcoded text**
                Text(
                  t('create_cv_title'),
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  t('generate_cv_subtitle'),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                   textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                _languageButton(context, 'English', 'en'),
                const SizedBox(height: 20),
                _languageButton(context, 'हिंदी', 'hi'), // Hindi
                const SizedBox(height: 20),
                _languageButton(context, 'বাংলা', 'bn'), // Bengali
                const SizedBox(height: 20),
                // You can translate this button's text as well
                _languageButton(context, t('choose_language'), 'en'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageButton(
      BuildContext context, String text, String languageCode) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1C2541),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.blueAccent),
          ),
        ),
        onPressed: () => _selectLanguage(context, languageCode),
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}