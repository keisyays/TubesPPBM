import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayerPage extends StatefulWidget {
  final String title;
  final String videoUrl;

  const YoutubeVideoPlayerPage({Key? key, required this.title, required this.videoUrl})
      : super(key: key);

  @override
  _YoutubeVideoPlayerPageState createState() => _YoutubeVideoPlayerPageState();
}

class _YoutubeVideoPlayerPageState extends State<YoutubeVideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.red,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player, // Pemutar Video
                ],
              );
            },
          ),
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    _controller.play();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.white),
                  onPressed: () {
                    _controller.pause();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop, color: Colors.white),
                  onPressed: () {
                    _controller.pause();
                    _controller.seekTo(Duration.zero);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
