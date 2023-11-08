class BannerModel {
  String? bannerImage;

  BannerModel({this.bannerImage});

  BannerModel.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['banner_image'] = bannerImage;
    return data;
  }
}
