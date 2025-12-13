import 'package:flutter/material.dart';
import 'home_screen.dart';

class SignUpOnLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Text(
                '',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 40),
              
              Center(
                child: Text(
                  'FocusNFLOW',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[800],
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              SizedBox(height: 80),
              
              // Login button
              _buildAuthButton(
                text: 'Log in',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              SizedBox(height: 20),
              
              // Sign Up button
              _buildAuthButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                isPrimary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton({
    required String text,
    required VoidCallback onPressed,
    bool isPrimary = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.blue[800] : Colors.transparent,
          foregroundColor: isPrimary ? Colors.white : Colors.blue[800],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isPrimary
                ? BorderSide.none
                : BorderSide(
                    color: Colors.blue[800]!,
                    width: 2,
                  ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}