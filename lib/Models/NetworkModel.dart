class NetworkModel {
  int? id;
  int? operatorId;
  String? name;
  bool? bundle;
  bool? data;
  bool? pin;
  bool? supportsLocalAmounts;
  String? denominationType;
  String? senderCurrencyCode;
  String? senderCurrencySymbol;
  String? destinationCurrencyCode;
  String? destinationCurrencySymbol;
  Country? country;
  String? image;
  List<String>? localFixedAmounts;
  List<String>? suggestedAmounts;
  String? status;

  NetworkModel({
    this.id,
    this.operatorId,
    this.name,
    this.bundle,
    this.data,
    this.pin,
    this.supportsLocalAmounts,
    this.denominationType,
    this.senderCurrencyCode,
    this.senderCurrencySymbol,
    this.destinationCurrencyCode,
    this.destinationCurrencySymbol,
    this.country,
    this.image,
    this.localFixedAmounts,
    this.suggestedAmounts,
    this.status,
  });

  NetworkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    operatorId = json['operatorId'];
    name = json['name'];
    bundle = json['bundle'];
    data = json['data'];
    pin = json['pin'];
    supportsLocalAmounts = json['supportsLocalAmounts'];
    denominationType = json['denominationType'];
    senderCurrencyCode = json['senderCurrencyCode'];
    senderCurrencySymbol = json['senderCurrencySymbol'];
    destinationCurrencyCode = json['destinationCurrencyCode'];
    destinationCurrencySymbol = json['destinationCurrencySymbol'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
    image = (json['logoUrls'] as List).isEmpty ? "" : json['logoUrls'][0];
    localFixedAmounts =
        (json['localFixedAmounts'] as List).map((e) => e.toString()).toList();
    suggestedAmounts =
        (json['suggestedAmounts'] as List).map((e) => e.toString()).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['operatorId'] = operatorId;
    data['name'] = name;
    data['bundle'] = bundle;
    data['data'] = data;
    data['pin'] = pin;
    data['supportsLocalAmounts'] = supportsLocalAmounts;
    data['denominationType'] = denominationType;
    data['senderCurrencyCode'] = senderCurrencyCode;
    data['senderCurrencySymbol'] = senderCurrencySymbol;
    data['destinationCurrencyCode'] = destinationCurrencyCode;
    data['destinationCurrencySymbol'] = destinationCurrencySymbol;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    data['logoUrls'] = image;
    data['localFixedAmounts'] = localFixedAmounts;
    data['suggestedAmounts'] = suggestedAmounts;
    data['status'] = status;
    return data;
  }
}

class Country {
  String? isoName;
  String? name;

  Country({this.isoName, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    isoName = json['isoName'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['isoName'] = isoName;
    data['name'] = name;
    return data;
  }
}
