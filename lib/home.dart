
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VideoPlayerWidget(),
    );
  }
}


class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoController;
  int videoIndex = 0;
  final List<String> assets = [
    "007595fe80fc28415372357d7ff78587",
    "08e3996a77b26ff5f3b59f034bb21c93",
    "4ce987086061b9f7e45bf013ba145503",
    "bae243f0ed4124a6489c07df45a61b62",
  ];

  @override
  void initState() {
    super.initState();

    _videoController = _setVideoController();
  }

  _setVideoController() {
    return VideoPlayerController.asset(
        'assets/videos/${assets[videoIndex]}.mp4')
      ..initialize().then((_) {
        _videoController.play();
        setState(() {});

        // Setup listener
        _videoController.addListener(() {
          final value = _videoController.value;
          if (value.position == value.duration) {
            bool isLastIndex = videoIndex == assets.length - 1;
            videoIndex = isLastIndex ? 0 : videoIndex + 1;
            
            _videoController = _setVideoController();
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _videoController.value.isInitialized
            ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController)),
              ])
            : Container(),
      ),
    );
  }
}
