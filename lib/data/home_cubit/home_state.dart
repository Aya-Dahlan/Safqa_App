import 'package:equatable/equatable.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/city_model.dart';
import 'package:safqa_app/data/models/post_model.dart';


enum CategoryStatus {
  initial,
  loading,
  success,
  failure,
}

enum PostsStatus {
  initial,
  loading,
  success,
  failure,
}

enum CategoryDetailsStatus {
  initial,
  loading,
  success,
  failure,
}

enum CitiesStatus {
  initial,
  loading,
  success,
  failure,
}

class HomeState extends Equatable{

  final CategoryStatus categoryStatus;
  final CitiesStatus citiesStatus;
  final CategoryDetailsStatus categoryDetailsStatus;
  final PostsStatus postsStatus;
  final List<CategoryModel> categories;
  final List<PostModel>? posts;
  final List<CategoryModel> subCategories;
  final List<CityModel> cities;
   List<CityModel> selectedRegions;
   late CategoryModel? selectedCategory;
  final String? errorMessage;
  // List<bool> selectedRegions= List.generate(7, (index) => false);




  HomeState({
    this.categoryStatus = CategoryStatus.initial,
    this.citiesStatus = CitiesStatus.initial,
    this.categoryDetailsStatus = CategoryDetailsStatus.initial,
    this.postsStatus = PostsStatus.initial,
    this.categories = const [],
    this.posts = const [],
    this.subCategories = const [],
    this.cities = const [],
    this.selectedCategory,


    this.selectedRegions = const [],


    this.errorMessage,
  });

  HomeState copyWith({
    CategoryStatus? categoryStatus,
    CitiesStatus? citiesStatus,
    CategoryDetailsStatus? categoryDetailsStatus,
    PostsStatus? postsStatus,
    List<CategoryModel>? categories,
    List<PostModel>? posts,
    List<CategoryModel>? subCategories,
    List<CityModel>? cities,
    List<CityModel>? selectedRegions,
    CategoryModel? selectedCategory,
    String? errorMessage,
  }) {
    return HomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      citiesStatus: citiesStatus ?? this.citiesStatus,
      categoryDetailsStatus: categoryDetailsStatus ?? this.categoryDetailsStatus,
      postsStatus: postsStatus ?? this.postsStatus,
      categories: categories ??this.categories,
      posts: posts ??this.posts,
      subCategories: subCategories ??this.subCategories,
      cities: cities ?? this.cities,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedRegions: selectedRegions ?? this.selectedRegions,
      errorMessage: errorMessage ??this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    categoryStatus,
    citiesStatus,
    categoryDetailsStatus,
    postsStatus,
    categories,
    posts,
    subCategories,
    cities,
    selectedCategory,
    selectedRegions,
    errorMessage,
  ];
}