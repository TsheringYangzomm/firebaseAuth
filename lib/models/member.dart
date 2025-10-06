// lib/models/member.dart

class Member {
  final String id;
  final String name;
  final String avatarUrl;
  final bool hasUnwatchedStory; 

  const Member({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.hasUnwatchedStory = false,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatarUrl'] as String,
      hasUnwatchedStory: json['hasUnwatchedStory'] as bool,
    );
  }
}