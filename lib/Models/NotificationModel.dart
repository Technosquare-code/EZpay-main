class NotificationModel {
  String? id;
  String? notiTitle;
  String? notiDescription;
  String? createdDate;

  NotificationModel({
    this.id,
    this.notiTitle,
    this.notiDescription,
    this.createdDate,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notiTitle = json['noti_title'];
    notiDescription = json['noti_description'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['noti_title'] = notiTitle;
    data['noti_description'] = notiDescription;
    data['created_date'] = createdDate;
    return data;
  }
}
