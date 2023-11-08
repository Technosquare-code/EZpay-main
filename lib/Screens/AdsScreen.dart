import 'package:billapp/Components/ServerAds.dart';
import 'package:billapp/Components/YoutubeAds.dart';
import 'package:billapp/Providers/VideoProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdsScreen extends StatefulWidget {
  static const routName = "/AdsScreen";
  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  changeVideo() {
    Provider.of<VideoProvider>(context, listen: false).setNewVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(builder: (context, value, child) {
      return Scaffold(
        body: value.videos![value.index].videoUrl != ""
            ? YoutubeAds(
                value.videos![value.index].videoUrl.toString(),
                changeVideo,
              )
            : ServerAds(
                value.videos![value.index].video.toString(),
                MediaQuery.of(context).size.aspectRatio,
                changeVideo,
              ),
      );
    });
  }
}
