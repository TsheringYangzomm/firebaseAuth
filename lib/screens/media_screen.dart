// lib/screens/media_screen.dart (FULL CODE)

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

// ----------------------------------------------------
// 1. VIDEO MODEL (New structure)
// ----------------------------------------------------
class Video {
  final String title;
  final String duration;
  final String views;
  final String thumbnailUrl;
  final String type; 

  const Video({
    required this.title,
    required this.duration,
    required this.views,
    required this.thumbnailUrl,
    required this.type,
  });
}

// ----------------------------------------------------
// 2. MOCK DATA (Using existing assets for thumbnails)
// ----------------------------------------------------
const List<Video> mockVideos = [
  Video(
    title: "Crimson Exclusive: Behind the Scenes Ep. 1",
    duration: "12:45",
    views: "1.2M Views",
    thumbnailUrl: 'images/enhypen_1.jpg', // Based on your asset list
    type: 'VOD',
  ),
  Video(
    title: "Crimson Exclusive: Behind the Scenes Ep. 2",
    duration: "15:00",
    views: "980K Views",
    thumbnailUrl: 'images/enhypen_2.jpeg', // Based on your asset list
    type: 'VOD',
  ),
  Video(
    title: "Crimson Exclusive: Behind the Scenes Ep. 3",
    duration: "10:30",
    views: "1.1M Views",
    thumbnailUrl: 'images/enhypen_3.jpeg', // Based on your asset list
    type: 'VOD',
  ),
  Video(
    title: "ENHYPEN Live: First Time Meeting ENGENE (Behind)",
    duration: "45:30",
    views: "5.5M Views",
    thumbnailUrl: 'images/enhypen_4.jpeg', // Based on your asset list
    type: 'LIVE',
  ),
  Video(
    title: "Crimson Exclusive: Behind the Scenes Ep. 5",
    duration: "18:22",
    views: "999K Views",
    thumbnailUrl: 'images/enhypen_5.jpeg', // Based on your asset list
    type: 'VOD',
  ),
  Video(
    title: "JAY's Food Review: Korean BBQ Edition",
    duration: "8:50",
    views: "1.5M Views",
    thumbnailUrl: 'avatars/jay_fixed.jpeg', // Based on your asset list
    type: 'VOD',
  ),
];


class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Media', style: theme.textTheme.titleLarge),
          backgroundColor: AppTheme.backgroundColor,
          elevation: 0,
          bottom: TabBar(
            // Ensure TabBar styling matches AppTheme
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.mutedColor,
            tabs: const [
              Tab(text: 'All Media'),
              Tab(text: 'VOD'),
              Tab(text: 'LIVE'),
              Tab(text: 'Playlists'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // All Media tab shows all videos
            _MediaTabContent(
              theme: theme, 
              title: 'All Videos (VODs, Clips, etc.)', 
              videos: mockVideos,
            ),
            // VOD tab filters for VOD type
            _MediaTabContent(
              theme: theme, 
              title: 'Past VOD Episodes',
              videos: mockVideos.where((v) => v.type == 'VOD').toList(),
            ),
            // LIVE tab filters for LIVE type
            _MediaTabContent(
              theme: theme, 
              title: 'Upcoming and Recent LIVEs',
              videos: mockVideos.where((v) => v.type == 'LIVE').toList(),
            ),
            // Playlists tab (No data filtering here, just placeholder)
            _MediaTabContent(
              theme: theme, 
              title: 'Curated Video Playlists', 
              videos: const [], // Empty list for now
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// 3. MEDIA TAB CONTENT (Now takes a video list)
// ----------------------------------------------------
class _MediaTabContent extends StatelessWidget {
  final ThemeData theme;
  final String title;
  final List<Video> videos;

  const _MediaTabContent({
    required this.theme, 
    required this.title, 
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          
          if (videos.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text('No videos found in this category.', style: theme.textTheme.bodyLarge),
              ),
            ),

          // Use ListView.builder to handle the list efficiently
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoCard(video: videos[index]); // Use the new VideoCard
            },
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 4. VIDEO CARD (Replaced _MediaListItem with visual improvements)
// ----------------------------------------------------
class VideoCard extends StatelessWidget {
  final Video video;
  
  const VideoCard({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: () {
        // TODO: Navigate to the Video Player screen
      },
      child: Container(
        height: 80, // Slightly reduced height for better density
        margin: const EdgeInsets.only(bottom: 16), // Increased margin for spacing
        // Note: Removed BoxDecoration color/borderRadius here to keep the Card theme clean
        
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // THUMBNAIL AREA (Visual Improvement)
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8), // Nicer rounded corners
                  child: Image.asset(
                    'assets/${video.thumbnailUrl}',
                    width: 140, 
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback if the asset path is wrong
                      return Container(
                        width: 140,
                        height: 80,
                        color: AppTheme.surfaceColor,
                        alignment: Alignment.center,
                        child: const Icon(Icons.play_arrow, color: AppTheme.mutedColor),
                      );
                    },
                  ),
                ),
                
                // Duration Badge (Overlay)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.75),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video.duration,
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(width: 12),

            // VIDEO DETAILS
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    style: theme.textTheme.titleSmall?.copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      // Views
                      Text(
                        video.views,
                        style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.mutedColor),
                      ),
                      
                      const SizedBox(width: 8),

                      // Optional: Show a dot separator if you add a timestamp/date later
                      // Container(width: 4, height: 4, decoration: BoxDecoration(color: AppTheme.mutedColor, shape: BoxShape.circle)),
                      // const SizedBox(width: 8),

                      // Optional: Show a "LIVE" indicator if needed
                      if (video.type == 'LIVE')
                        Text(
                          'LIVE',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}