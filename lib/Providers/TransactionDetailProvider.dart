import 'package:billapp/Models/TransactionDetailModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TransactionDetailProvider with ChangeNotifier {
  Dio dio = Dio();
  TransactionDetailModel? transaction;

  Future<void> getTransactionDetail(String orderId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "order_id": orderId,
      });
      var response = await dio.post(transactionDetialUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        transaction = TransactionDetailModel.fromJson(response.data['data']);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
