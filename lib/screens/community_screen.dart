class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Community', style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => _buildCommunityItem(),
      ),
    );
  }

  Widget _buildCommunityItem() {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://example.com/user-profile.jpg'),
      ),
      title: Text('User Nickname', style: TextStyle(color: Colors.white)),
      subtitle: Text('Posted in ENHYPEN Community', style: TextStyle(color: Colors.grey)),
      trailing: Text('2h ago', style: TextStyle(color: Colors.grey)),
    );
  }
}