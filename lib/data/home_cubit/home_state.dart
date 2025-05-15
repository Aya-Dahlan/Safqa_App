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

enum FavoriteStatus {
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
  final FavoriteStatus favoriteStatus;
  final PostsStatus postsStatus;
  final List<CategoryModel> categories;
  final List<PostModel>? posts;
  final List<PostModel>? myFavoritePosts;
  final List<PostModel>? filterdPosts;
  final List<CategoryModel> subCategories;
  final List<CityModel> cities;
   List<CityModel> selectedRegions;
   late CategoryModel? selectedCategory;
   late CategoryModel? selectedCategoryForCreatePost;
   late CategoryModel? subSelectedCategory;
  final String? errorMessage;
  // List<bool> selectedRegions= List.generate(7, (index) => false);




  HomeState({
    this.categoryStatus = CategoryStatus.initial,
    this.citiesStatus = CitiesStatus.initial,
    this.categoryDetailsStatus = CategoryDetailsStatus.initial,
    this.postsStatus = PostsStatus.initial,
    this.favoriteStatus = FavoriteStatus.initial,
    this.categories = const [],
    this.posts = const [],
    this.myFavoritePosts = const [],
    this.filterdPosts = const [],
    this.subCategories = const [],
    this.cities = const [],
    this.selectedCategory,
    this.subSelectedCategory,
    this.selectedCategoryForCreatePost,


    this.selectedRegions = const [],


    this.errorMessage,
  });

  HomeState copyWith({
    CategoryStatus? categoryStatus,
    CitiesStatus? citiesStatus,
    CategoryDetailsStatus? categoryDetailsStatus,
    PostsStatus? postsStatus,
    FavoriteStatus? favoriteStatus,
    List<CategoryModel>? categories,
    List<PostModel>? posts,
    List<PostModel>? myFavoritePosts,
    List<PostModel>? filterdPosts,
    List<CategoryModel>? subCategories,
    List<CityModel>? cities,
    List<CityModel>? selectedRegions,
    CategoryModel? selectedCategory,
    CategoryModel? selectedCategoryForCreatePost,
    CategoryModel? subSelectedCategory,
    String? errorMessage,
  }) {
    return HomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      citiesStatus: citiesStatus ?? this.citiesStatus,
      categoryDetailsStatus: categoryDetailsStatus ?? this.categoryDetailsStatus,
      postsStatus: postsStatus ?? this.postsStatus,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
      categories: categories ??this.categories,
      posts: posts ??this.posts,
      myFavoritePosts: myFavoritePosts ??this.myFavoritePosts,
      filterdPosts: filterdPosts ??this.filterdPosts,
      subCategories: subCategories ??this.subCategories,
      cities: cities ?? this.cities,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      subSelectedCategory: subSelectedCategory ?? this.subSelectedCategory,
      selectedRegions: selectedRegions ?? this.selectedRegions,
      selectedCategoryForCreatePost: selectedCategoryForCreatePost ?? this.selectedCategoryForCreatePost,
      errorMessage: errorMessage ??this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    categoryStatus,
    citiesStatus,
    categoryDetailsStatus,
    favoriteStatus,
    postsStatus,
    categories,
    posts,
    myFavoritePosts,
    filterdPosts,
    subCategories,
    cities,
    selectedCategory,
    subSelectedCategory,
    selectedCategoryForCreatePost,
    selectedRegions,
    errorMessage,
  ];
}