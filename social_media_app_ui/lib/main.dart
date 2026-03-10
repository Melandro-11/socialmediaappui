import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FacebookApp());
}

class FacebookApp extends StatelessWidget {
  const FacebookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1877F2),
          primary: const Color(0xFF1877F2),
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0.5,
          centerTitle: false,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.openSans(
            color: const Color(0xFF1877F2),
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
        ),
      ),
      home: const FacebookHome(),
    );
  }
}

class FacebookHome extends StatelessWidget {
  const FacebookHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('facebook'),
        actions: [
          _circleButton(Icons.add),
          _circleButton(Icons.search),
          Stack( // FEATURE 1: Notification Badge sa Messenger
            children: [
              _circleButton(Icons.messenger),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: const Text('3', style: TextStyle(color: Colors.white, fontSize: 10)),
                ),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          const CreatePostHeader(),
          const SizedBox(height: 10),

          // FEATURE 2: Stories Section (Horizontal Scroll)
          const StorySection(),
          const SizedBox(height: 10),

          // FEATURE 3: Maraming Posts para sa mahabang scroll
          const PostCard(
            user: "Juan Dela Cruz",
            time: "5m",
            content: "Kape muna tayo! ☕ Sobrang ganda ng weather ngayon.",
            imageUrl: "https://images.unsplash.com/photo-1509042239860-f550ce710b93",
          ),

          const PostCard(
            user: "Travel Goals",
            time: "2h",
            content: "Sino gusto sumama sa Boracay next month? 🏝️ TAG MO NA FRIENDS MO!",
            imageUrl: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e",
            isSponsored: true, // FEATURE 4: Sponsored post
          ),

          const PostCard(
            user: "Chef Master",
            time: "5h",
            content: "My special Adobo recipe is finally out! Watch the full video. 🍲",
            imageUrl: "https://images.unsplash.com/photo-1546069901-ba9599a7e63c",
            isVideo: true, // FEATURE 5: Video overlay icon
          ),

          const PostCard(
            user: "Tech News PH",
            time: "1d",
            content: "Apple just announced a new gadget! 📱 #TechNews #Apple",
            imageUrl: "https://images.unsplash.com/photo-1510511459019-5dee997d7db4",
          ),

          const PostCard(
            user: "Motivator Daily",
            time: "3d",
            content: "Huwag kang susuko. Malayo pa, pero malayo na. ✨",
            imageUrl: "https://images.unsplash.com/photo-1499750310107-5fef28a66643",
          ),

          const PostCard(
            user: "Flutter Dev Philippines",
            time: "Just now",
            content: "Gumawa ako ng Facebook Clone gamit ang Flutter! Ang daling mag-scroll! 🔥",
            imageUrl: "https://images.unsplash.com/photo-1517694712202-14dd9538aa97",
          ),

          // Karagdagang space sa dulo
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: Text("Wala ka nang mai-scroll. Matulog ka na! 😂", style: TextStyle(color: Colors.grey))),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
      child: IconButton(icon: Icon(icon, size: 22), onPressed: () {}),
    );
  }
}

// --- WIDGET PARA SA STORIES (FEATURE 2) ---
class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(10),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            width: 110,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage("https://picsum.photos/200/300?random=$index"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 8, left: 8,
                  child: Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.blue, width: 2)),
                    child: const CircleAvatar(radius: 15, backgroundColor: Colors.grey),
                  ),
                ),
                const Positioned(
                  bottom: 8, left: 8,
                  child: Text("User Name", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- WIDGET PARA SA CREATE POST ---
class CreatePostHeader extends StatelessWidget {
  const CreatePostHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Colors.blueAccent, child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Ano ang nasa isip mo?",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.grey[300]!)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- WIDGET PARA SA POST CARD (MAHUSAY NA DESIGN) ---
class PostCard extends StatelessWidget {
  final String user, time, content, imageUrl;
  final bool isSponsored;
  final bool isVideo;

  const PostCard({
    super.key, required this.user, required this.time, required this.content, required this.imageUrl,
    this.isSponsored = false, this.isVideo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150")),
            title: Text(user, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row(
              children: [
                Text(isSponsored ? "Sponsored • " : "$time • "),
                Icon(isSponsored ? Icons.public : Icons.people, size: 12, color: Colors.grey[600]),
              ],
            ),
            trailing: const Icon(Icons.more_horiz),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Text(content),
          ),
          Stack( // FEATURE 5: Video Play Icon
            alignment: Alignment.center,
            children: [
              Image.network(imageUrl, fit: BoxFit.cover, height: 250, width: double.infinity),
              if (isVideo) const Icon(Icons.play_circle_fill, color: Colors.white70, size: 60),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.thumb_up, size: 16, color: Color(0xFF1877F2)),
                SizedBox(width: 5),
                Text("99+"),
                Spacer(),
                Text("24 Comments • 10 Shares"),
              ],
            ),
          ),
          const Divider(height: 1, indent: 15, endIndent: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _bottomButton(Icons.thumb_up_alt_outlined, "Like"),
              _bottomButton(Icons.mode_comment_outlined, "Comment"),
              _bottomButton(Icons.share_outlined, "Share"),
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomButton(IconData icon, String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.grey[600], size: 20),
      label: Text(label, style: TextStyle(color: Colors.grey[600])),
    );
  }
}