class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          title: Text('ENHYPEN', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
          ],
        ),
        SliverToBoxAdapter(
          child: _buildBannerSection(),
        ),
        SliverToBoxAdapter(
          child: _buildQuickMenu(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildPostItem(),
            childCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildBannerSection() {
    return Container(
      height: 200,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage('https://example.com/enhypen-banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildQuickMenu() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildMenuButton('Notice', Icons.announcement),
          _buildMenuButton('Schedule', Icons.calendar_today),
          _buildMenuButton('Photo', Icons.photo_library),
          _buildMenuButton('Video', Icons.video_library),
        ],
      ),
    );
  }

  Widget _buildMenuButton(String title, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[800],
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }

  Widget _buildPostItem() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://example.com/profile.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ENHYPEN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('2 hours ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Hello ENGENE! We have exciting news for you...',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 12),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage('https://example.com/post-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.grey, size: 20),
              SizedBox(width: 8),
              Text('1.2K', style: TextStyle(color: Colors.grey)),
              SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline, color: Colors.grey, size: 20),
              SizedBox(width: 8),
              Text('245', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}