// import 'package:billapp/Models/InfoModel.dart';
// import 'package:billapp/Urls/Urls.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class InfoProvider with ChangeNotifier {
//   Dio dio = Dio();
//   InfoModel? info;

//   Future<void> getInfoContent(String slug, String token) async {
//     try {
//       final data = FormData.fromMap({
//         "slug": slug,
//       });
//       var response = await dio.post(
//         infoUrl,
//         data: data,
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );
//       print("Response: ${response.data}");
//       if (response.data["status"] == true) {
//         info = InfoModel.fromJson(response.data["data"]);
//         notifyListeners();
//       } else {
//         info = InfoModel();
//         notifyListeners();
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   void clear() {
//     info = null;
//   }
// }
