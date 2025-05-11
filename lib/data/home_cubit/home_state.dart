import 'package:equatable/equatable.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/city_model.dart';


enum CategoryStatus {
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
  final List<CategoryModel> categories;
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
    this.categories = const [],
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
    List<CategoryModel>? categories,
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
      categories: categories ??this.categories,
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
    categories,
    subCategories,
    cities,
    selectedCategory,
    selectedRegions,
    errorMessage,
  ];
}