import 'package:flutter/material.dart';
import '../theme/app_theme.dart'; // Ensure you have your AppTheme defined here

// 1. DUMMY DATA/VARIABLES for placeholders
class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  // We'll use a placeholder for the image file path initially
  String? _imagePath;
  final TextEditingController _captionController = TextEditingController();
  
  // Dummy function for selecting an image (simulates the logic)
  void _selectImage() {
    setState(() {
      // Simulate selecting an image. In a real app, this would use image_picker.
      // We'll just set a placeholder path to change the UI state.
      _imagePath = 'assets/images/enhypen_1.jpg'; // Use a known asset for testing
    });
  }

  void _sharePost() {
    final caption = _captionController.text;
    // In a real app: Send data to Node.js backend
    print('Sharing Post: Image: $_imagePath, Caption: $caption');
    
    // Clear fields and pop the screen
    _captionController.clear();
    setState(() {
      _imagePath = null;
    });
    Navigator.of(context).pop(); 
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      // 2. APP BAR (Weverse style: "New Post" and "Share")
      appBar: AppBar(
        title: const Text('New Post', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: _imagePath != null && _captionController.text.isNotEmpty ? _sharePost : null,
            child: Text(
              'Share',
              style: TextStyle(
                // Button is primary color when active, muted when inactive
                color: _imagePath != null && _captionController.text.isNotEmpty
                    ? AppTheme.primaryColor
                    : AppTheme.mutedColor.withOpacity(0.5),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      
      // 3. BODY CONTENT
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SELECTION AREA
            GestureDetector(
              onTap: _selectImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppTheme.mutedColor.withOpacity(0.3)),
                ),
                child: _imagePath == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.camera_alt_outlined, size: 40, color: AppTheme.mutedColor),
                          SizedBox(height: 8),
                          Text(
                            'Tap to select image',
                            style: TextStyle(color: AppTheme.mutedColor),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          _imagePath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Basic fallback for asset errors
                            return const Center(child: Text("Image Error"));
                          },
                        ),
                      ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // CAPTION INPUT AREA
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _captionController,
                onChanged: (text) {
                  // Rebuild to update the "Share" button state
                  setState(() {});
                },
                maxLines: 5, // Allow multiple lines for a full caption
                maxLength: 500, // Matches your existing limit
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  hintStyle: TextStyle(color: AppTheme.mutedColor),
                  border: InputBorder.none,
                  counterText: "", // Hide default counter
                ),
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ),
            
            // Custom Character Counter (Weverse style)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  '${_captionController.text.length}/500',
                  style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // TAG MEMBERS / CATEGORIES (Weverse uses this for posting to a specific community)
            _buildPostOptionRow(
              icon: Icons.person_add_alt_1_outlined, 
              text: 'Tag Members', 
              onTap: () {},
            ),
            const Divider(color: AppTheme.surfaceColor, height: 1),
            _buildPostOptionRow(
              icon: Icons.tag, 
              text: 'Select Category', 
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build the option rows
  Widget _buildPostOptionRow({required IconData icon, required String text, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.mutedColor, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: AppTheme.mutedColor, size: 24),
          ],
        ),
      ),
    );
  }
}