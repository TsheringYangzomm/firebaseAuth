// lib/theme/app_theme.dart (FINAL POLISHED VERSION)

import 'package:flutter/material.dart';

class AppTheme {
  // --- COLOR PALETTE ---
  static const Color primaryColor = Color(0xFFE31B23); 
  static const Color secondaryColor = Color(0xFFC41E3A); 
  static const Color backgroundColor = Color(0xFF121212); 
  static const Color surfaceColor = Color(0xFF1E1E1E); 
  static const Color textColor = Color(0xFFE0E0E0); 
  static const Color mutedColor = Color(0xFFAAAAAA); 

  // --- DARK THEME DEFINITION ---
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        background: backgroundColor,
        onSurface: textColor,
        onBackground: textColor,
      ),
      scaffoldBackgroundColor: backgroundColor,

      appBarTheme: const AppBarTheme(
        color: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),

      textTheme: const TextTheme(
        titleLarge: TextStyle(color: textColor, fontSize: 22, fontWeight: FontWeight.w800),
        titleMedium: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: textColor, fontSize: 15, height: 1.4),
        bodyMedium: TextStyle(color: mutedColor, fontSize: 13),
        bodySmall: TextStyle(color: mutedColor, fontSize: 11),
      ),

      iconTheme: const IconThemeData(color: mutedColor, size: 24),
      
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),

      cardTheme: const CardThemeData(
        color: surfaceColor,
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: mutedColor),
      ),
      
      tabBarTheme: const TabBarThemeData(
        labelColor: primaryColor,
        unselectedLabelColor: mutedColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: primaryColor, width: 2.5),
        ),
      )
    );
  }
}