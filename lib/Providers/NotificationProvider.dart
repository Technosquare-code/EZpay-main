import 'package:billapp/Models/NotificationModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  Dio dio = Dio();
  List<NotificationModel>? notifications;

  Future<void> getNotification(String userId) async {
    try {
      final data = FormData.fromMap({
        "uid": userId,
        "token": token,
      });
      var response = await dio.post(notificationUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<NotificationModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(NotificationModel.fromJson(element));
        }
        notifications = result;
        notifyListeners();
      } else {
        notifications = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void clear() {
    notifications = null;
  }
}
