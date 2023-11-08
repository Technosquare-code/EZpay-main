class VideoModel {
  String? title;
  String? videoUrl;
  String? video;

  VideoModel({this.title, this.videoUrl, this.video});

  VideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    videoUrl = json['video_url'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['video_url'] = videoUrl;
    data['video'] = video;
    return data;
  }
}
