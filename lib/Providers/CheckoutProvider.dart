import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CheckoutProvider with ChangeNotifier {
  Dio dio = Dio();
  String? amount;
  String? agencyFee;

  setAmount(String a) {
    amount = a;
  }

  Future<void> getInfoContent(String category) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "category_name": category,
      });
      var response = await dio.post(
        adminComissonUrl,
        data: data,
      );
      print("Response: ${response.data}");
      if (response.data['code'].toString() == "4") {
        agencyFee = response.data['data']['agency_fee'].toString();
        amount = response.data['data']['admin_commission'].toString();
        notifyListeners();
      } else {
        amount = "0";
        agencyFee = "0";
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void clear() {
    amount = null;
  }
}
