import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/main_navigation_screen.dart'; // 👈 Updated import

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isLogin = true;
  bool _isForgotPassword = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  // 🔹 LOGIN
  Future<void> _login() async {
    setState(() => _isLoading = true);
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Login failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 🔹 SIGN UP
  Future<void> _signup() async {
    setState(() => _isLoading = true);
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCred.user?.updateDisplayName(_nameController.text.trim());
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Signup failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 🔹 RESET PASSWORD
  Future<void> _resetPassword() async {
    setState(() => _isLoading = true);
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      _showSuccess('Password reset link sent to your email!');
      setState(() {
        _isForgotPassword = false;
      });
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Password reset failed');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // 🔹 ERROR MESSAGE
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  // 🔹 SUCCESS MESSAGE
  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Replace the StreamBuilder part in your auth_page.dart build method:
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.lightBlue[50],
    body: StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // ✅ if user is logged in, go to MainNavigationScreen
        if (snapshot.hasData && snapshot.data != null) {
          // Use Future.microtask to navigate after build completes
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
            );
          });
          return const Center(child: CircularProgressIndicator());
        }

        // else show auth forms
        return _buildAuthForm();
      },
    ),
  );
}

  // 🔹 AUTH FORM
  Widget _buildAuthForm() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App Icon/Logo
                Icon(
                  Icons.shopping_bag,
                  size: 60,
                  color: Colors.lightBlue[700],
                ),
                const SizedBox(height: 16),
                
                Text(
                  _isForgotPassword
                      ? 'Reset Password'
                      : _isLogin
                          ? 'Welcome Back'
                          : 'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlue[800],
                  ),
                ),
                
                Text(
                  _isForgotPassword
                      ? 'Enter your email to reset password'
                      : _isLogin
                          ? 'Sign in to continue'
                          : 'Join us today!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),

                if (!_isLogin && !_isForgotPassword)
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person, color: Colors.lightBlue[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                if (!_isLogin && !_isForgotPassword) const SizedBox(height: 16),

                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    prefixIcon: Icon(Icons.email, color: Colors.lightBlue[700]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 16),

                if (!_isForgotPassword) ...[
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.lightBlue[700]),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility : Icons.visibility_off,
                          color: Colors.lightBlue[700],
                        ),
                        onPressed: () =>
                            setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                if (!_isLogin && !_isForgotPassword)
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.lightBlue[700]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),

                if (!_isLogin && !_isForgotPassword) const SizedBox(height: 16),

                const SizedBox(height: 24),

                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isForgotPassword) {
                              _resetPassword();
                            } else if (_isLogin) {
                              _login();
                            } else {
                              if (_passwordController.text.trim() !=
                                  _confirmPasswordController.text.trim()) {
                                _showError('Passwords do not match');
                                return;
                              }
                              _signup();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[700],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                          ),
                          child: Text(
                            _isForgotPassword
                                ? 'Send Reset Link'
                                : _isLogin
                                    ? 'Sign In'
                                    : 'Create Account',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                const SizedBox(height: 20),

                if (!_isForgotPassword)
                  TextButton(
                    onPressed: () =>
                        setState(() => _isForgotPassword = true),
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.lightBlue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isForgotPassword
                          ? 'Remember your password?'
                          : _isLogin
                              ? "Don't have an account?"
                              : 'Already have an account?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          if (_isForgotPassword) {
                            _isForgotPassword = false;
                            _isLogin = true;
                          } else {
                            _isLogin = !_isLogin;
                          }
                        });
                      },
                      child: Text(
                        _isForgotPassword
                            ? 'Sign In'
                            : _isLogin
                                ? 'Sign Up'
                                : 'Sign In',
                        style: TextStyle(
                          color: Colors.lightBlue[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}