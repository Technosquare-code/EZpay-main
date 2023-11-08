import 'package:billapp/Models/SubAgentModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SubAgentProvider with ChangeNotifier {
  Dio dio = Dio();
  List<SubAgentModel>? subAgents;

  Future<void> getSubAgents(String agentId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": agentId,
      });
      var response = await dio.post(getSubAgentUrl, data: data);
      print("Response: ${response.data}");
      if (response.data["code"].toString() == "4") {
        List<SubAgentModel> result = [];
        for (var element in (response.data["data"] as List)) {
          result.add(SubAgentModel.fromJson(element));
        }
        subAgents = result;
        notifyListeners();
      } else {
        subAgents = [];
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void clear() {
    subAgents = null;
  }

  Future<String> addSubAgent(SubAgentModel subAgent, String agentId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": agentId,
        "subagent_id": subAgent.id,
        "name": subAgent.name,
        "mobile": subAgent.mobile,
        "email": subAgent.email,
        "password": subAgent.password,
        "city": subAgent.city,
        "post_code": subAgent.postCode,
        "address": subAgent.address,
      });
      var response = await dio.post(addEditSubAgentUrl, data: data);
      if (response.data["code"].toString() == "23") {
        await getSubAgents(agentId);
      }
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<String> deleteSubAgent(String subAgentId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "subagent_id": subAgentId,
      });
      var response = await dio.post(deleteSubAgentUrl, data: data);
      if (response.data["code"].toString() == "25") {
        subAgents!.removeWhere((element) => element.id == subAgentId);
        notifyListeners();
      }
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<String> addSubAgentWallet(
      String subAgentId, String agentId, String amount) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "amount": amount,
        "agent_id": agentId,
        "subagent_id": subAgentId,
      });
      var response = await dio.post(subAgentTopupUrl, data: data);
      return response.data["code"];
    } catch (e) {
      print(e);
      return "0";
    }
  }
}
