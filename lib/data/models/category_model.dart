import 'package:safqa_app/data/models/sub_category_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final String? description;
  final List<CategoryModel> children;
  final int parentId;
  final String? image;
  late  bool isSelected ;

  CategoryModel({
    required this.id,
    required this.name,
    required this.children,
    required this.parentId,
    required this.description,
    required this.image,
     this.isSelected= false,
  });


  factory CategoryModel.fromJson(Map<String,dynamic> json){
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : [],
      parentId: json['parent_id'] ?? 0,
      image: json['image'] ?? null,
      description: json['description'] ?? null,
      isSelected: json['isSelected'] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'children': children,
      'parentId': parentId,
      'description': description,
      'isSelected': isSelected,
    };
  }
}