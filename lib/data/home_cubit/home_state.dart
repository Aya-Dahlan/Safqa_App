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
  final List<CityModel> cities;
   List<CityModel> selectedRegions;
  final String? errorMessage;
  // List<bool> selectedRegions= List.generate(7, (index) => false);




  HomeState({
    this.categoryStatus = CategoryStatus.initial,
    this.citiesStatus = CitiesStatus.initial,
    this.categoryDetailsStatus = CategoryDetailsStatus.initial,
    this.categories = const [],
    this.cities = const [],

    this.selectedRegions = const [],


    this.errorMessage,
  });

  HomeState copyWith({
    CategoryStatus? categoryStatus,
    CitiesStatus? citiesStatus,
    CategoryDetailsStatus? categoryDetailsStatus,
    List<CategoryModel>? categories,
    List<CityModel>? cities,
    List<CityModel>? selectedRegions,
    String? errorMessage,
  }) {
    return HomeState(
      categoryStatus: categoryStatus ?? this.categoryStatus,
      citiesStatus: citiesStatus ?? this.citiesStatus,
      categoryDetailsStatus: categoryDetailsStatus ?? this.categoryDetailsStatus,
      categories: categories ??this.categories,
      cities: cities ?? this.cities,
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
    cities,
    selectedRegions,
    errorMessage,
  ];
}