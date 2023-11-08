import 'package:billapp/Models/TransactionModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  Dio dio = Dio();
  double totalSales = 0;
  int totalOrder = 0;
  List<TransactionModel>? transactions;

  Future<void> getTransactions(
      String userId, DateTime fromDate, DateTime toDate) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": userId,
      });
      var response = await dio.post(transactionHistoryUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<TransactionModel> result = [];
        for (var element in (response.data["data"] as List)) {
          if (DateTime.parse(element['created_date'].toString().split(" ")[0])
                  .add(const Duration(days: 1))
                  .isAfter(fromDate) &&
              DateTime.parse(element['created_date'].toString().split(" ")[0])
                  .subtract(const Duration(days: 1))
                  .isBefore(toDate)) {
            totalOrder++;
            totalSales = double.parse(element['amount']) + totalSales;
            result.add(TransactionModel.fromJson(element));
          }
        }
        transactions = result;
        notifyListeners();
      } else {
        transactions = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void update() {
    transactions = null;
    totalSales = 0;
    totalOrder = 0;
    notifyListeners();
  }

  void clear() {
    totalSales = 0;
    totalOrder = 0;
    transactions = null;
  }
}
