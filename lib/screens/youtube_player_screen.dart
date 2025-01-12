import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'youtube_video_player_page.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen({Key? key}) : super(key: key);

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  final List<Map<String, String>> videos = [
    {
      "title": "Flutter Basic Training - 12 Minute Bootcamp",
      "url": "https://www.youtube.com/watch?v=1xipg02Wu8s",
    },
    {
      "title": "Dart Programming Tutorial",
      "url": "https://www.youtube.com/watch?v=Ej_Pcr4uC2Q",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "YouTube Video Player",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return VideoCard(
              title: video["title"]!,
              url: video["url"]!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => YoutubeVideoPlayerPage(
                      title: video["title"]!,
                      videoUrl: video["url"]!,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      backgroundColor: Colors.grey[900],
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String url;
  final VoidCallback onTap;

  const VideoCard({Key? key, required this.title, required this.url, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: Colors.black,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: YoutubePlayerController(
                    initialVideoId: YoutubePlayer.convertUrlToId(url)!,
                    flags: const YoutubePlayerFlags(autoPlay: false),
                  ),
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                ),
                builder: (context, player) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: player,
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
