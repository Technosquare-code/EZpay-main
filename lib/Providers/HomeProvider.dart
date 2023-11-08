import 'package:billapp/Models/BannerModel.dart';
import 'package:billapp/Models/CategoryModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider with ChangeNotifier {
  Dio dio = Dio();
  List<CategoryModel>? categories;
  List<BannerModel>? banners;

  Future<void> getCategories() async {
    try {
      final data = FormData.fromMap({
        "token": token,
      });
      var response = await dio.post(categoryUrl, data: data);
      print("Response: ${response.data}");
      var pref = await SharedPreferences.getInstance();
      var type = pref.getString("type");
      if (response.data["code"].toString() == "4") {
        List<CategoryModel> result = [];
        for (var element in (response.data["data"] as List)) {
          if (type == "agent") {
            result.add(CategoryModel.fromJson(element));
          } else {
            if (element["category_name"] != "Port-In") {
              result.add(CategoryModel.fromJson(element));
            }
          }
        }
        categories = result;
        notifyListeners();
      } else {
        categories = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getBanners() async {
    try {
      final data = FormData.fromMap({
        "token": token,
      });
      var response = await dio.post(bannerUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<BannerModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(BannerModel.fromJson(element));
        }
        banners = result;
        notifyListeners();
      } else {
        banners = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
