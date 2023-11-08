class CategoryModel {
  String? id;
  String? categoryName;
  String? categoryIcon;

  CategoryModel({this.id, this.categoryName, this.categoryIcon});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    categoryIcon = json['category_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['category_icon'] = categoryIcon;
    return data;
  }
}
