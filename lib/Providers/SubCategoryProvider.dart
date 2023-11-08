import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubCategoryProvider with ChangeNotifier {
  Dio dio = Dio();
  List<SubCategoryModel>? subCategories;

  Future<void> getSubCategories(String categoryId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "category_id": categoryId,
      });
      var response = await dio.post(subCategoryUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<SubCategoryModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(SubCategoryModel.fromJson(element));
        }
        subCategories = result;
        notifyListeners();
      } else {
        subCategories = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void clear() {
    subCategories = null;
  }
}
