class PlanModel {
  String? id;
  String? planName;
  String? planPrice;
  String? planIcon;
  String? comission;

  PlanModel({
    this.id,
    this.planName,
    this.planPrice,
    this.planIcon,
    this.comission,
  });

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planName = json['plan_name'];
    planPrice = json['plan_price'];
    planIcon = json['plan_icon'];
    comission = json['admin_commission'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['plan_name'] = planName;
    data['plan_price'] = planPrice;
    data['plan_icon'] = planIcon;
    data['admin_commission'] = comission;
    return data;
  }
}
