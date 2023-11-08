class UserModel {
  String? id;
  String? agentId;
  String? name;
  String? email;
  String? mobile;
  String? city;
  String? postCode;
  String? address;
  String? profilePicture;
  String? password;
  String? wallet;
  String? fcmToken;
  String? status;
  String? createdDate;

  UserModel({
    this.id,
    this.agentId,
    this.name,
    this.email,
    this.mobile,
    this.city,
    this.postCode,
    this.address,
    this.profilePicture,
    this.password,
    this.wallet,
    this.fcmToken,
    this.status,
    this.createdDate,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentId = json['agent_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    city = json['city'];
    postCode = json['post_code'];
    address = json['address'];
    profilePicture = json['profile_picture'];
    password = json['password'];
    wallet = json['wallet'];
    fcmToken = json['fcm_token'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['agent_id'] = agentId;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['city'] = city;
    data['post_code'] = postCode;
    data['address'] = address;
    data['profile_picture'] = profilePicture;
    data['password'] = password;
    data['wallet'] = wallet;
    data['fcm_token'] = fcmToken;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}
