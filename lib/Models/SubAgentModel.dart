class SubAgentModel {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? city;
  String? postCode;
  String? address;
  String? wallet;
  String? profilePicture;
  String? password;

  SubAgentModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.city,
    this.postCode,
    this.address,
    this.wallet,
    this.profilePicture,
    this.password,
  });

  SubAgentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    mobile = json['mobile'] ?? "";
    city = json['city'] ?? "";
    postCode = json['post_code'] ?? "";
    address = json['address'] ?? "";
    wallet = json['wallet'] ?? "";
    profilePicture = json['profile_picture'] ?? "";
    password = json['password'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['city'] = city;
    data['post_code'] = postCode;
    data['address'] = address;
    data['wallet'] = wallet;
    data['profile_picture'] = profilePicture;
    data['password'] = password;
    return data;
  }
}
