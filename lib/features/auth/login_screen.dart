import 'package:flutter/material.dart';
import '../core/constants/colors.dart'; // Import your SicapColors

class SicapLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SicapColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400, // Fixed width for the "Centered Card" look
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: SicapColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. THE BLUE HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: SicapColors.primaryBlue,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.business_center, color: Colors.white, size: 50),
                      SizedBox(height: 10),
                      Text(
                        "SICAP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. THE FORM AREA
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Please enter your credentials to access your portal.",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 32),

                      // Email Field
                      Text("Email Address", style: TextStyle(fontWeight: FontWeight.w600)),
                      SizedBox(height: 8),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "name@sicap.org",
                          // The theme already handles borders from app_theme.dart
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Password Field
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Password", style: TextStyle(fontWeight: FontWeight.w600)),
                          TextButton(onPressed: () {}, child: Text("Forgot?")),
                        ],
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "••••••••",
                          prefixIcon: Icon(Icons.lock_outline),
                          suffixIcon: Icon(Icons.visibility_off_outlined),
                        ),
                      ),
                      SizedBox(height: 32),

                      // 3. THE YELLOW SIGN-IN BUTTON
                      // The style is already set in app_theme.dart
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sign In"),
                            SizedBox(width: 10),
                            Icon(Icons.logout_rounded),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text("Don't have an account? Create Account"),
                        ),
                      ),
                    ],
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