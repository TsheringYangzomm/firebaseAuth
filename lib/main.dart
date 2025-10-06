// lib/main.dart

import 'package:flutter/material.dart';
//import 'package:provider/provider.dart'; // NEW
//import 'providers/post_provider.dart'; // NEW
import 'screens/main_screen.dart'; 
import 'screens/login_screen.dart'; // <<< NEW IMPORT
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crimson App',
      theme: AppTheme.darkTheme, 
      // <<< CHANGED: App starts with the Login Screen
      home: const LoginScreen(), 
      
      debugShowCheckedModeBanner: false,
    );
  }
}