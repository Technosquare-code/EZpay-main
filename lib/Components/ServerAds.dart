import 'package:billapp/Urls/Urls.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ServerAds extends StatefulWidget {
  final String video;
  final double aspectRatio;
  final Function() setNewVideo;

  const ServerAds(this.video, this.aspectRatio, this.setNewVideo);
  @override
  _ServerAdsState createState() => _ServerAdsState();
}

class _ServerAdsState extends State<ServerAds> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.network("$videoBaseUrl${widget.video}");
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: widget.aspectRatio,
      showControls: false,
      showControlsOnInitialize: false,
      allowFullScreen: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      autoInitialize: true,
      isLive: false,
      placeholder: Image.asset("assets/images/logo.png"),
      showOptions: false,
      zoomAndPan: false,
    );
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isInitialized &&
          videoPlayerController.value.position ==
              videoPlayerController.value.duration) {
        widget.setNewVideo();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Chewie(controller: chewieController),
    );
  }
}
