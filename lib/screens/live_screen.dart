import 'package:flutter/material.dart';
// NOTE: You must import your custom theme and constants
import '../theme/app_theme.dart';

class LiveScreen extends StatelessWidget {
  // Add const constructor for best practice
  const LiveScreen({super.key});

  // Use a constant for the Live Now banner image
  final String _liveNowImage = 'images/enhypen_4.jpeg'; // Using an asset from your list
  
  // Use a constant for the Upcoming Live item image
  final String _upcomingImage = 'images/enhypen_2.jpeg'; // Using an asset from your list

  @override
  Widget build(BuildContext context) {
    // Get the current theme for text styles
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor, // Use theme background color
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor, // Use theme background color
        elevation: 0, // Optional: remove shadow
        title: Text(
          'Live', 
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          _buildLiveNowSection(theme),
          _buildUpcomingLiveSection(theme),
        ],
      ),
    );
  }

  Widget _buildLiveNowSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Live Now', 
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // TODO: Navigate to the live video player
          },
          child: Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // FIX: Use Image.asset with local path
              image: DecorationImage(
                image: AssetImage('assets/$_liveNowImage'), // Use local asset
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red, // Prominent red for LIVE indicator
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'LIVE', 
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                // Add a gradient overlay for text readability (optional but recommended)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                    ),
                  ),
                ),
                // Live title/details at the bottom
                const Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: Text(
                    'ENHYPEN Live: First Time Meeting ENGENE!', 
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingLiveSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Upcoming Live', 
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Mock count
          itemBuilder: (context, index) => _buildUpcomingLiveItem(theme, index),
        ),
      ],
    );
  }

  Widget _buildUpcomingLiveItem(ThemeData theme, int index) {
    return InkWell(
      onTap: () {
        // TODO: Show a notification/reminder prompt
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor, // Use theme surface color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                // FIX: Use Image.asset with local path
                image: DecorationImage(
                  image: AssetImage('assets/$_upcomingImage'), // Use local asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ENHYPEN Live: Q&A Session #${index + 1}', // Dynamic title
                    style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tomorrow, 8:00 PM KST', // Static time for mock
                    style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor), // Use muted color
                  ),
                ],
              ),
            ),
            // Add a reminder bell icon
            Icon(Icons.notifications_none, color: AppTheme.mutedColor),
          ],
        ),
      ),
    );
  }
}