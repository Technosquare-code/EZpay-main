import 'package:billapp/Models/CountryModel.dart';
import 'package:billapp/Models/NetworkModel.dart';
import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MobileTopupProvider with ChangeNotifier {
  Dio dio = Dio();
  String? reloadlyToken;
  List<CountryModel>? countries;
  List<NetworkModel> networks = [];

  Future<void> getToken() async {
    try {
      var response = await dio.post(
        getTokenUrl,
        data: {
          "client_id": clientId,
          "client_secret": clientSecret,
          "grant_type": "client_credentials",
          "audience": "https://topups.reloadly.com",
        },
      );
      if (response.statusCode == 200) {
        reloadlyToken = response.data["access_token"];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCountries() async {
    try {
      var response = await dio.get(
        getCountriesUrl,
        options: Options(headers: {
          "Authorization": "Bearer $reloadlyToken",
          "Accept": "application/com.reloadly.topups-v1+json",
        }),
      );
      if (response.statusCode == 200) {
        List<CountryModel> result = [];
        for (var element in (response.data as List)) {
          result.add(CountryModel.fromJson(element));
        }
        countries = result;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getNetworks(String countryCode) async {
    try {
      var response = await dio.get(
        "$getNetworkUrl$countryCode",
        options: Options(headers: {
          "Authorization": "Bearer $reloadlyToken",
        }),
      );
      if (response.statusCode == 200) {
        print("Respnse: ${response.data}");
        List<NetworkModel> result = [];
        for (var element in (response.data as List)) {
          result.add(NetworkModel.fromJson(element));
        }
        networks = result;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> mobileTopup(
      String network, String amount, String country, String number) async {
    try {
      var response = await dio.post(
        mobileTopUpUrl,
        options: Options(headers: {
          "Authorization": "Bearer $reloadlyToken",
          "Accept": "application/com.reloadly.topups-v1+json",
          "Content-Type": "application/json",
        }),
        data: {
          "operatorId": network,
          "amount": amount,
          "useLocalAmount": false,
          "recipientPhone": {
            "countryCode": country,
            "number": number,
          },
        },
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        return response.data["message"];
      }
    } on DioError catch (e) {
      print(e.response!.data);
      return e.response!.data["message"];
    }
  }

  Future<void> getData() async {
    try {
      await getToken();
      await getCountries();
    } catch (e) {
      print(e);
    }
  }
}
