import 'dart:math';

import 'package:billapp/Models/VideoModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoProvider with ChangeNotifier {
  Dio dio = Dio();
  int index = 0;
  List<VideoModel>? videos;

  setNewVideo() {
    // index = 0;
    // notifyListeners();
    int min = 0;
    int max = videos!.length;
    int result = min + Random().nextInt(max - min);
    if (result != index) {
      index = result;
      notifyListeners();
      print("New : ?????????$index");
    } else {
      int result2 = min + Random().nextInt(max - min);
      index = result2;
      notifyListeners();
    }
  }

  Future<void> getVideos() async {
    try {
      final data = FormData.fromMap({
        "token": token,
      });
      var response = await dio.post(getVideoListUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<VideoModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(VideoModel.fromJson(element));
        }
        videos = result;
        // notifyListeners();
      } else {
        videos = [];
        // notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

// info for AgoraRTC
  Future<void> getVideoCallInfo() async {
    try {
      final data = FormData.fromMap({
        "token": token,
      });
      var response = await dio.post(getVideoCallToken, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        final pref = await SharedPreferences.getInstance();
        await pref.setString(
            "appID", response.data["data"]['app_id'].toString());
        await pref.setString(
            "tempToken", response.data["data"]['token_value'].toString());
        await pref.setString(
            "channelName", response.data["data"]['channel_name'].toString());
      } else {
        // videos = [];
        // notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
