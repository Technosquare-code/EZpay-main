import 'package:billapp/Urls/Urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PaymentProvider with ChangeNotifier {
  Dio dio = Dio();

  Future<Map<String, dynamic>> userPayment({
    String? agentId,
    String? mobile,
    String? amount,
    String? insureComp,
    String? account,
    String? mobile2,
    String? mobile3,
    String? mobile4,
    String? mobile5,
    String? mobile6,
    String? carreir,
    String? planId,
    String? firstName,
    String? lastName,
    String? email,
    String? giftcard,
    String? longComp,
    String? country,
    String? network,
    String? simNo,
    String? imei,
    String? zip,
    String? state,
    String? city,
    String? customerAdd,
    String? customerAccount,
    String? customerPin,
    String? portNo,
    String? callBack,
    String? cardNumber,
    String? cardExp,
    String? provider,
    String? categoryName,
    String? isCategory,
    String? carInsurance,
    String? comcast,
    String? directv,
    String? dishNetwork,
    String? electricBill,
    String? fios,
    String? fpl,
    String? peco,
    String? philadelphiaGasWorks,
    String? waterSewerage,
    String? xfinityPrepaid,
    String? attPostpaid,
    String? tMobilePostpaid,
    String? verizonPostpaid,
    String? deviceId,
    String? isInternationalRecharge,
    String? invoice,
    String? license,
    String? licenseState,
    String? plate,
    String? plateNo,
    String? ticket,
    String? dob,
    String? passenger,
    String? commercial,
    String? isEzpass,
    String? isParkingTicket,
    String? isMotorVehicleTax,
  }) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": agentId ?? "",
        "mobile_number": mobile ?? "",
        "amount": amount ?? "",
        "insurance_company": insureComp ?? "",
        "account_no": account ?? "",
        "mobile_number_2": mobile2 ?? "",
        "mobile_number_3": mobile3 ?? "",
        "mobile_number_4": mobile4 ?? "",
        "mobile_number_5": mobile5 ?? "",
        "mobile_number_6": mobile6 ?? "",
        "carrier": carreir ?? "",
        "plan_id": planId ?? "",
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "email": email ?? "",
        "gift_Card": giftcard ?? "",
        "long_distance_company": longComp ?? "",
        "country": country ?? "",
        "network": network ?? "",
        "sim_number": simNo ?? "",
        "IMEI": imei ?? "",
        "zipcode": zip ?? "",
        "state": state ?? "",
        "city": city ?? "",
        "customer_address": customerAdd ?? "",
        "customer_account_number": customerAccount ?? "",
        "customer_pin": customerPin ?? "",
        "port_number": portNo ?? "",
        "call_back_number": callBack ?? "",
        "CCNumber": cardNumber ?? "",
        "CCExpDate": cardExp ?? "",
        "provider": provider ?? "",
        "is_category": isCategory ?? "1",
        "car_insurance": carInsurance ?? "1",
        "comcast": comcast ?? "1",
        "directv": directv ?? "1",
        "dish_network": dishNetwork ?? "1",
        "electric_bill": electricBill ?? "1",
        "fios": fios ?? "1",
        "fpl": fpl ?? "1",
        "peco": peco ?? "1",
        "philadelphia_gas_works": philadelphiaGasWorks ?? "1",
        "water_sewerage": waterSewerage ?? "1",
        "xfinity_prepaid": xfinityPrepaid ?? "1",
        "category_name": categoryName,
        "att_postpaid": attPostpaid,
        "t_mobile_postpaid": tMobilePostpaid,
        "verizon_postpaid": verizonPostpaid,
        "kiosk_id": deviceId,
        "is_international_recharge": isInternationalRecharge,
        "invoice_number": invoice,
        "license_plate": license,
        "license_plate_state": licenseState,
        "license_plate_reg_number": plate,
        "plate_no": plateNo,
        "passenger_type": passenger,
        "commercial_type": commercial,
        "dob": dob,
        "ticket_no": ticket,
      });
      var response = await dio.post(paymentUrl, data: data);
      print("Response: ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      return {
        'data': "Something went wrong please try again later.",
        'code': "0",
      };
    }
  }

  Future<String> userOrderStatusMange(String orderId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "order_id": orderId,
      });
      var response = await dio.post(userOrderStatusMangeUrl, data: data);
      print("Response: ${response.data}");
      return response.data['code'];
    } catch (e) {
      print(e);
      return "0";
    }
  }

  Future<Map<String, dynamic>> agentPayment({
    String? agentId,
    String? mobile,
    String? amount,
    String? insureComp,
    String? account,
    String? mobile2,
    String? mobile3,
    String? mobile4,
    String? mobile5,
    String? mobile6,
    String? carreir,
    String? planId,
    String? firstName,
    String? lastName,
    String? email,
    String? giftcard,
    String? longComp,
    String? country,
    String? network,
    String? simNo,
    String? imei,
    String? zip,
    String? state,
    String? city,
    String? customerAdd,
    String? customerAccount,
    String? customerPin,
    String? portNo,
    String? callBack,
    String? provider,
    String? isCategory,
    String? carInsurance,
    String? comcast,
    String? directv,
    String? dishNetwork,
    String? electricBill,
    String? fios,
    String? fpl,
    String? peco,
    String? philadelphiaGasWorks,
    String? waterSewerage,
    String? xfinityPrepaid,
    String? categoryName,
    String? attPostpaid,
    String? tMobilePostpaid,
    String? verizonPostpaid,
    String? isInternationalRecharge,
    String? invoice,
    String? license,
    String? licenseState,
    String? plate,
    String? plateNo,
    String? ticket,
    String? dob,
    String? passenger,
    String? commercial,
    String? isEzpass,
    String? isParkingTicket,
    String? isMotorVehicleTax,
  }) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "agent_id": agentId ?? "",
        "mobile_number": mobile ?? "",
        "amount": amount ?? "",
        "insurance_company": insureComp ?? "",
        "account_no": account ?? "",
        "mobile_number_2": mobile2 ?? "",
        "mobile_number_3": mobile3 ?? "",
        "mobile_number_4": mobile4 ?? "",
        "mobile_number_5": mobile5 ?? "",
        "mobile_number_6": mobile6 ?? "",
        "carrier": carreir ?? "",
        "plan_id": planId ?? "",
        "first_name": firstName ?? "",
        "last_name": lastName ?? "",
        "email": email ?? "",
        "gift_Card": giftcard ?? "",
        "long_distance_company": longComp ?? "",
        "country": country ?? "",
        "network": network ?? "",
        "sim_number": simNo ?? "",
        "IMEI": imei ?? "",
        "zipcode": zip ?? "",
        "state": state ?? "",
        "city": city ?? "",
        "customer_address": customerAdd ?? "",
        "customer_account_number": customerAccount ?? "",
        "customer_pin": customerPin ?? "",
        "port_number": portNo ?? "",
        "call_back_number": callBack ?? "",
        "provider": provider ?? "",
        "is_category": isCategory ?? "",
        "car_insurance": carInsurance ?? "",
        "comcast": comcast ?? "",
        "directv": directv ?? "",
        "dish_network": dishNetwork ?? "",
        "electric_bill": electricBill ?? "",
        "fios": fios ?? "",
        "fpl": fpl ?? "",
        "peco": peco ?? "",
        "philadelphia_gas_works": philadelphiaGasWorks ?? "",
        "water_sewerage": waterSewerage ?? "",
        "xfinity_prepaid": xfinityPrepaid ?? "",
        "category_name": categoryName ?? "",
        "att_postpaid": attPostpaid ?? "",
        "t_mobile_postpaid": tMobilePostpaid ?? "",
        "verizon_postpaid": verizonPostpaid ?? "",
        "is_international_recharge": isInternationalRecharge ?? "",
        "invoice_number": invoice ?? "",
        "license_plate": license ?? "",
        "license_plate_state": licenseState ?? "",
        "license_plate_reg_number": plate ?? "",
        "plate_no": plateNo ?? "",
        "passenger_type": passenger ?? "",
        "commercial_type": commercial ?? "",
        "dob": dob ?? "",
        "ticket_no": ticket ?? "",
        "is_ezpass": isEzpass,
        "is_parking_tickets": isParkingTicket,
        "is_motor_vehicle_excise_tax": isMotorVehicleTax,
      });
      var response = await dio.post(agentPaymentUrl, data: data);
      print("Response: ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      return {'code': '0'};
    }
  }

  Future<String> agentOrderStatusMange(String orderId) async {
    try {
      final data = FormData.fromMap({
        "token": token,
        "order_id": orderId,
      });
      var response = await dio.post(agentOrderStatusMangeUrl, data: data);
      print("Response: ${response.data}");
      return response.data['code'];
    } catch (e) {
      print(e);
      return "0";
    }
  }
}
