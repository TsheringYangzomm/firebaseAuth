import 'package:flutter/material.dart';
import '../screens/add_post_screen.dart'; // Import to use the Member class

class MemberTagSelector extends StatefulWidget {
  final List<Member> allMembers;
  final List<Member> initialSelectedMembers;

  const MemberTagSelector({
    super.key,
    required this.allMembers,
    required this.initialSelectedMembers,
  });

  @override
  State<MemberTagSelector> createState() => _MemberTagSelectorState();
}

class _MemberTagSelectorState extends State<MemberTagSelector> {
  // Use a temporary list to manage selection state
  late List<Member> _currentSelectedMembers;

  @override
  void initState() {
    super.initState();
    // Copy the initial list so we don't modify the parent's state directly
    _currentSelectedMembers = List.from(widget.initialSelectedMembers);
  }

  // Toggle selection state for a member
  void _toggleMember(Member member) {
    setState(() {
      if (_currentSelectedMembers.contains(member)) {
        _currentSelectedMembers.removeWhere((m) => m.id == member.id);
      } else {
        _currentSelectedMembers.add(member);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tag Members'),
        actions: [
          TextButton(
            onPressed: () {
              // Return the final list of selected members to the previous screen
              Navigator.of(context).pop(_currentSelectedMembers);
            },
            child: const Text('Done', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.allMembers.length,
        itemBuilder: (context, index) {
          final member = widget.allMembers[index];
          final isSelected = _currentSelectedMembers.any((m) => m.id == member.id);

          return ListTile(
            leading: CircleAvatar(
              child: Text(member.username[0].toUpperCase()),
            ),
            title: Text(member.username),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : const Icon(Icons.circle_outlined, color: Colors.grey),
            onTap: () => _toggleMember(member),
          );
        },
      ),
    );
  }
}