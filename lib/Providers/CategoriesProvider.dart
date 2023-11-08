import 'package:billapp/Models/PlanModel.dart';
import 'package:billapp/Models/SubCategoryModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CategoriesProvider with ChangeNotifier {
  Dio dio = Dio();
  List<SubCategoryModel>? subCategories;

  Future<void> getSubCategories(String categoryId) async {
    print(categoryId);
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
        result.map((e) => e.image = "$categoryImgUrl${e.image}").toList();
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

  Future<List<PlanModel>> getPlans(
      String categoryId, String subCategoryId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "category_id": categoryId,
        "subcategory_id": subCategoryId,
      });
      var response = await dio.post(planListUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<PlanModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(PlanModel.fromJson(element));
        }
        return result;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  void clear() {
    subCategories = null;
  }
}
