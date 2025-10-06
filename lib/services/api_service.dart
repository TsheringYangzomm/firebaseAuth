// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';
import '../models/member.dart';
import '../data/api_constants.dart';

class ApiService {
  // --- FETCH POSTS ---
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$kBaseUrl/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> postJson = jsonDecode(response.body);
      return postJson.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts from API: ${response.statusCode}');
    }
  }

  // --- FETCH MEMBERS/STORIES ---
  Future<List<Member>> fetchMembers() async {
    final response = await http.get(Uri.parse('$kBaseUrl/members'));

    if (response.statusCode == 200) {
      final List<dynamic> memberJson = jsonDecode(response.body);
      return memberJson.map((json) => Member.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load members from API');
    }
  }
}