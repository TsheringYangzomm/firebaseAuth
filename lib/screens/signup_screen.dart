// lib/screens/signup_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // State for password visibility
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Controllers to access text field values
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // --- VALIDATION METHODS ---

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Simple regex for email format validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value) || !value.endsWith('@gmail.com')) {
      return 'Please enter a valid @gmail.com address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    // Example for strong password: Must contain upper, lower, digit, and symbol
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Must contain an uppercase letter.';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Must contain a lowercase letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Must contain a digit.';
    }
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Must contain a symbol (!@#\$&*~).';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirming password is required.';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match.';
    }
    return null;
  }

  void _handleRegistration() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with registration logic
      // Get values:
      // final username = _usernameController.text; // (You would need a controller for username too)
      final email = _emailController.text;
      final password = _passwordController.text;
      
      // TODO: Call API to register the user
      
      // For now, just navigate back (pop) after a successful validation
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful for $email!')),
      );
      Navigator.of(context).pop(); 
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: theme.textTheme.titleMedium),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
      ),
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form( // Wrap inputs in a Form widget
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Join the Community',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),

                // Username Input
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: const Icon(Icons.person_outline, color: AppTheme.mutedColor),
                  ),
                  // No validator needed for simple username
                ),
                const SizedBox(height: 16),

                // Email Input
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    prefixIcon: const Icon(Icons.email_outlined, color: AppTheme.mutedColor),
                  ),
                  validator: _validateEmail, // Attach email validator
                ),
                const SizedBox(height: 16),

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible, // Controlled by state
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline, color: AppTheme.mutedColor),
                    // NEW: Eye Icon to toggle visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppTheme.mutedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: _validatePassword, // Attach password validator
                ),
                const SizedBox(height: 16),
                
                // Confirm Password Input
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible, // Controlled by state
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_reset_outlined, color: AppTheme.mutedColor),
                    // NEW: Eye Icon to toggle visibility
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: AppTheme.mutedColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  validator: _validateConfirmPassword, // Attach confirm password validator
                ),
                const SizedBox(height: 24),

                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _handleRegistration, // Call the validation and registration handler
                  child: Text(
                    'REGISTER',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
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