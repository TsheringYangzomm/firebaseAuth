import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; 

class MemberDetailScreen extends StatelessWidget {
  final String stageName;
  final String name;
  final String imagePath;
  final String description;

  const MemberDetailScreen({
    super.key,
    required this.stageName,
    required this.name,
    required this.imagePath,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$stageName Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            // CORRECTED: Using primaryAccent (Cyan) for the title
            color: AppTheme.primaryAccent,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- 1. MEMBER IMAGE ---
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    // CORRECTED: Using primaryAccent for the glow effect
                    color: AppTheme.primaryAccent.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio( 
                  aspectRatio: 16 / 9, 
                  child: Image.asset(
                    'assets/$imagePath', 
                    fit: BoxFit.cover, 
                    errorBuilder: (context, error, stackTrace) => Container(
                      // CORRECTED: Using surfaceColor for the error background
                      color: AppTheme.surfaceColor.withOpacity(0.5),
                      alignment: Alignment.center,
                      child: const Icon(Icons.person, color: AppTheme.textColor, size: 100),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // --- 2. NAMES ---
            Text(
              stageName,
              style: theme.textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w900,
                // CORRECTED: Using actionRed (Crimson) for the main stage name
                color: AppTheme.actionRed,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                // CORRECTED: Using mutedColor for the real name
                color: AppTheme.mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            
            // --- 3. SEPARATOR ---
            const Divider(
              height: 40, 
              // CORRECTED: Using surfaceColor for the subtle divider
              color: AppTheme.surfaceColor, 
              thickness: 2
            ),

            // --- 4. DESCRIPTION/BIOGRAPHY ---
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Biography:',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textColor,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              description,
              textAlign: TextAlign.justify,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                color: AppTheme.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}