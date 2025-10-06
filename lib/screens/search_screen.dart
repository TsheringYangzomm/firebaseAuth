// lib/screens/search_screen.dart

import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 16.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppTheme.textColor),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    autofocus: true,
                    style: theme.textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText: 'Search posts, members, and tags',
                      hintStyle: theme.textTheme.bodyMedium,
                      prefixIcon: const Icon(Icons.search, color: AppTheme.mutedColor, size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                    onSubmitted: (query) {
                      print('Search submitted for: $query');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending Searches',
              style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.textColor),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: const [
                _SearchTagChip(label: '#Comeback2025'),
                _SearchTagChip(label: '#JAY'),
                _SearchTagChip(label: 'Concert Tickets'),
                _SearchTagChip(label: '#CrimsonFanArt'),
                _SearchTagChip(label: '#HEESEUNG'),
              ],
            ),
            
            const Divider(height: 40, color: AppTheme.surfaceColor),
            
            Text(
              'Recent History',
              style: theme.textTheme.titleMedium?.copyWith(color: AppTheme.textColor),
            ),
            const SizedBox(height: 12),
            const _RecentSearchItem(query: 'SungHoon selca'),
            const _RecentSearchItem(query: '#ENHYPEN_Official'),
            const _RecentSearchItem(query: 'New Merch'),
          ],
        ),
      ),
    );
  }
}

class _SearchTagChip extends StatelessWidget {
  final String label;
  
  const _SearchTagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.primaryColor),
      backgroundColor: AppTheme.primaryColor.withOpacity(0.15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppTheme.primaryColor, width: 0.5),
      ),
      onPressed: () {},
    );
  }
}

class _RecentSearchItem extends StatelessWidget {
  final String query;
  
  const _RecentSearchItem({required this.query});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.history, color: AppTheme.mutedColor, size: 20),
      title: Text(
        query,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.close, color: AppTheme.mutedColor, size: 18),
        onPressed: () {},
      ),
      onTap: () {},
    );
  }
}