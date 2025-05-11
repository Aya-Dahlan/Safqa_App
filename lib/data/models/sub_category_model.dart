class SubCategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? image;


  SubCategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });


  factory SubCategoryModel.fromJson(Map<String,dynamic> json){
    return SubCategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] ?? null,
      description: json['description'] ?? null,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
    };
  }
}