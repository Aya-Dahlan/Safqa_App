class CategoryModel {
  final int id;
  final String name;
  // final String? description;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    // required this.description,
    required this.image,
  });


  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] ?? null,
      // description: json['description'] ?? null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      // 'description': description,
    };
  }
}