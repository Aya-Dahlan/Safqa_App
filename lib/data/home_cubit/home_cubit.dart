import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/city_model.dart';
import 'package:safqa_app/data/repos/home_repo.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState>{
  final HomeRepository _homeRepository;


  HomeCubit(this._homeRepository) : super(HomeState());



  Future<void> loadHomeData() async {
    emit(state.copyWith(
      categoryStatus: CategoryStatus.loading,
      citiesStatus: CitiesStatus.loading,
    ));
    await Future.wait([
      getCategories(),
      getCities()
    ]);
    emit(state.copyWith(
      categoryStatus: CategoryStatus.success,
      citiesStatus: CitiesStatus.success,
    ));
  }


  //filter category

  filterCategory(int id,int index){
    List<CategoryModel> newCategories= state.categories.where(
            (element) {
          return element.parentId == id;
        }
    ).toList();


    emit(
      state.copyWith(
        subCategories: newCategories
      )
    );
  }


  // select category

  void selectCategory(int index,int id) {

    List<CategoryModel> newCategories= state.categories.where(
            (element) {
          return element.parentId == id;
        }
    ).toList();



    for (var element in state.categories) {
      element.isSelected = false;
    }
    state.categories[index].isSelected = true;

    emit(
      state.copyWith(
        selectedCategory: state.categories[index],
        categories: state.categories,
        subCategories: newCategories
      )
    );


  }



  selectRegion(int index) {
    state.cities[index].isSelected =
    !state.cities[index].isSelected!;



    state.selectedRegions = state.cities
        .where((city) => city.isSelected!)
        .toList();
    emit(state.copyWith(
      cities: state.cities,
      selectedRegions: state.selectedRegions,
    ));
}

  Future<void> getCategories() async{

    emit(state.copyWith(categoryStatus: CategoryStatus.loading));
    try {
      final categories = await _homeRepository.getCategories();
      emit(state.copyWith(
        categoryStatus: CategoryStatus.success,

        categories: categories,
      ));
    } catch (e) {
      emit(state.copyWith(
        categoryStatus: CategoryStatus.failure,
        errorMessage: e.toString(),
        categories: [],
      ));
    }

  }

  // get details category

  Future <void> getDetailsCategory(int parentId) async {
    emit(state.copyWith(categoryDetailsStatus: CategoryDetailsStatus.loading));
    try {
      final subCategories = await _homeRepository.getDetailsCategory(parentId);
      emit(state.copyWith(
        categoryDetailsStatus: CategoryDetailsStatus.success,
        subCategories: subCategories,
      ));
    } catch (e) {
      emit(state.copyWith(
        categoryDetailsStatus: CategoryDetailsStatus.failure,
        errorMessage: e.toString(),
        categories: [],
      ));
    }
  }


  //getCategoryDetails

  // Future<void> getCategoryDetails({required int id}) async {
  //   emit(state.copyWith(categoryDetailsStatus: CategoryDetailsStatus.loading));
  //   try {
  //     final categoryDetails = await _homeRepository.getCategoryDetails(id:id);
  //     emit(state.copyWith(
  //       categoryDetailsStatus: CategoryDetailsStatus.success,
  //       categories: categoryDetails,
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //       categoryDetailsStatus: CategoryDetailsStatus.failure,
  //       errorMessage: e.toString(),
  //       categories: [],
  //     ));
  //   }
  // }

  //get cities

Future<void> getCities() async {
    emit(state.copyWith(citiesStatus: CitiesStatus.loading));
    try {
      final cities = await _homeRepository.getCities();
      emit(state.copyWith(
        citiesStatus: CitiesStatus.success,
        cities: cities,
      ));
    } catch (e) {
      emit(state.copyWith(
        citiesStatus: CitiesStatus.failure,
        errorMessage: e.toString(),
        cities: [],
      ));
    }
  }

}