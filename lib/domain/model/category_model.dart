class CategoryModel {
  String? id;
  String? imgUrl;
  String? name;
  String? status;

  CategoryModel({required this.id, required this.status, required this.name, required this.imgUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        id: json['id'],
        status: json['status'],
        name: json['name'],
        imgUrl: json['imgUrl'],
    );
  }
}
