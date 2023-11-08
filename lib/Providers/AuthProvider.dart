import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:billapp/Models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  Dio dio = Dio();
  UserModel? currentUser;
  bool isTryAutoLogin = true;
  String? type;

  Future<String> login(String email, String password) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "email": email,
        "password": password,
      });
      var response = await dio.post(loginUrl, data: data);
      print(response.data);
      if (response.data["code"] == "4") {
        currentUser = UserModel.fromJson(response.data["data"]);
      }
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<String> updateUser() async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": currentUser!.id,
      });
      var response = await dio.post(getAgentDetailUrl, data: data);
      if (response.data["code"].toString() == "4") {
        currentUser = UserModel.fromJson(response.data["data"]);
        notifyListeners();
      }
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<void> savePassword(String password, String email) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString("email", email);
    await pref.setString("password", password);
  }

  Future<String> tryAutoLogin() async {
    final pref = await SharedPreferences.getInstance();
    var password = pref.getString("password");
    var email = pref.getString("email");
    type = pref.getString("type");
    if (type == null) {
      await Future.delayed(const Duration(seconds: 1));
      return "0";
    }
    if (password == null || email == null) {
      await Future.delayed(const Duration(seconds: 2));
      if (type == "agent") {
        isTryAutoLogin = false;
        return "1";
      } else {
        isTryAutoLogin = false;
        return "2";
      }
    } else {
      var result = await login(email, password);
      if (result == "4") {
        isTryAutoLogin = false;
        return "3";
      } else if (result == "0") {
        return "4";
      } else {
        return "5";
      }
    }
  }

  Future<String> editUser(String name, String mobile, File? image) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "name": name,
        "uid": currentUser!.id,
        "mobile": mobile,
        "profile_picture": currentUser!.profilePicture ?? "",
        "image":
            image == null ? null : await MultipartFile.fromFile(image.path),
      });
      var response = await dio.post(agentUpdateUrl, data: data);
      print("Response: ${response.data}");
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<void> updateAgentFcmToken(String fcmToken) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "uid": currentUser!.id,
        "fcm_token": fcmToken,
      });
      var response = await dio.post(updateFcmTokenUrl, data: data);
      print("Response: ${response.data}");
    } catch (e) {
      print(e);
    }
  }

  Future<String> changePassword(String oldPassword, String newPassword) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "uid": currentUser!.id,
        "current_password": oldPassword,
        "new_password": newPassword,
      });
      var response = await dio.post(changePasswordUrl, data: data);
      if (response.data["code"].toString() == "15") {
        final pref = await SharedPreferences.getInstance();
        var p = pref.getString("password");
        if (p != null) {
          await pref.setString("password", newPassword);
        }
      }
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  logout() async {
    isTryAutoLogin = true;
    final pref = await SharedPreferences.getInstance();
    await pref.remove("mobile");
    await pref.remove("password");
  }

  Future<String> forgotPassword(String email) async {
    try {
      final data = FormData.fromMap({
        "email": email,
        "token": token,
      });
      var response = await dio.post(forgetPasswordUrl, data: data);
      print("Response: ${response.data}");
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }
}
