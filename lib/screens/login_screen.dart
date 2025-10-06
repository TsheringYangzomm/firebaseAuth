// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_screen.dart'; // To navigate after successful login
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // State for password visibility
  bool _isPasswordVisible = false;

  // Controllers to access text field values
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- VALIDATION METHODS ---

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Simple regex for email format validation (can be made stricter if needed)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    // Simple length check for login, more complex checks should be in signup
    if (value.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed with login logic
      // final email = _emailController.text;
      // final password = _passwordController.text;
      
      // TODO: Call API to authenticate the user
      
      // On successful login, navigate to MainScreen (The feed) and replace the route
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
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
                // Logo/App Title (Weverse style uses bold branding)
                Text(
                  'CRIMSON',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.primaryColor,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'FAN PLATFORM',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.mutedColor,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 50),

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
                const SizedBox(height: 24),

                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _handleLogin, // Call the validation and login handler
                  child: Text(
                    'LOGIN',
                    style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                
                // Forgot Password Link
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                    );
                  },
                  child: Text(
                    'Forgot Password?',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mutedColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppTheme.mutedColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: AppTheme.surfaceColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('OR', style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor)),
                    ),
                    const Expanded(child: Divider(color: AppTheme.surfaceColor)),
                  ],
                ),
                const SizedBox(height: 40),

                // Sign Up Button
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    side: const BorderSide(color: AppTheme.primaryColor, width: 1.5),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: Text(
                    'CREATE NEW ACCOUNT',
                    style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.primaryColor),
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