import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeAds extends StatefulWidget {
  final String video;
  final Function()? onEnd;

  const YoutubeAds(this.video, this.onEnd);
  @override
  _YoutubeAdsState createState() => _YoutubeAdsState();
}

class _YoutubeAdsState extends State<YoutubeAds> {
  late YoutubePlayerController _controller;
  late String videoId;

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.video).toString();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: true,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: true,
        hideThumbnail: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onEnterFullScreen: () {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        },
        onExitFullScreen: () {
          SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        },
        player: YoutubePlayer(
          controller: _controller,
          onEnded: (_) => widget.onEnd,
          showVideoProgressIndicator: true,
          aspectRatio: MediaQuery.of(context).size.width /
              MediaQuery.of(context).size.height,
          progressIndicatorColor: Colors.blueAccent,
        ),
        builder: (context, player) {
          return player;
        });
  }
}
