class CountryModel {
  String? isoName;
  String? name;
  String? continent;
  String? currencyCode;
  String? currencyName;
  String? currencySymbol;
  String? image;
  List<String>? callingCodes;

  CountryModel({
    this.isoName,
    this.name,
    this.continent,
    this.currencyCode,
    this.currencyName,
    this.currencySymbol,
    this.image,
    this.callingCodes,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    isoName = json['isoName'];
    name = json['name'];
    continent = json['continent'];
    currencyCode = json['currencyCode'];
    currencyName = json['currencyName'];
    currencySymbol = json['currencySymbol'];
    image = json['flag'] ?? "";
    callingCodes = json['callingCodes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['isoName'] = isoName;
    data['name'] = name;
    data['continent'] = continent;
    data['currencyCode'] = currencyCode;
    data['currencyName'] = currencyName;
    data['currencySymbol'] = currencySymbol;
    data['flag'] = image;
    data['callingCodes'] = callingCodes;
    return data;
  }
}
