class Video {
  final String title;
  final String duration;
  final String views;
  final String thumbnailUrl; // New field for the image asset path
  final String type; // e.g., 'VOD', 'LIVE'

  const Video({
    required this.title,
    required this.duration,
    required this.views,
    required this.thumbnailUrl,
    required this.type,
  });
}