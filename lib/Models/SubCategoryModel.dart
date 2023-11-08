class SubCategoryModel {
  String? id;
  String? name;
  String? image;

  SubCategoryModel({this.id, this.name, this.image});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['subcategory'];
    image = json['category_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['subcategory'] = name;
    data['category_icon'] = image;
    return data;
  }
}
