import 'package:flutter/foundation.dart';
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
      getCities(),
      getHomePosts(),

    ]);
    emit(state.copyWith(
      categoryStatus: CategoryStatus.success,
      citiesStatus: CitiesStatus.success,
    ));
  }



  selectCategoryForCreatePost(CategoryModel category){
    emit(state.copyWith(
      selectedCategoryForCreatePost: category
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

  void selectCategory(int index,int id,List<CategoryModel> items) async{
    print(items[index].name);
    List<CategoryModel> copyOfOriginalList= List<CategoryModel>.from(state.categories);

    List<CategoryModel> newCategories= copyOfOriginalList.where(
            (element) {
              // print(id);
          return element.parentId == id;
        }
    ).toList();




    for (var element in items) {
      element.isSelected = false;
    }
    for (var element in newCategories) {
      element.isSelected = false;
    }
    items[index].isSelected = true;

    emit(
      state.copyWith(
        selectedCategory: copyOfOriginalList[index],
        categories: copyOfOriginalList,
        subCategories: newCategories
      )
    );

    await  getHomePosts(categoryId: items[index].id);



  }

  void selectSubCategory(int index,List<CategoryModel> list) async{
    for (var element in list) {
      element.isSelected = false;
    }
    list[index].isSelected = true;

    emit(
        state.copyWith(
            subSelectedCategory: list[index],
            subCategories: list
        )
    );

  await  getHomePosts(categoryId: list[index].id);


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

  Future<void> getHomePosts({int? categoryId}) async{

    emit(state.copyWith(postsStatus: PostsStatus.loading));
    try {
      final posts = await _homeRepository.getHomePosts(categoryId:categoryId);
      if(categoryId!=null){
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          filterdPosts: posts,
        ));
      }else{
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          posts: posts,
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        postsStatus: PostsStatus.failure,
        errorMessage: e.toString(),
        posts: [],
      ));
    }

  }



  Future<void> getMyFavorites() async{

    emit(state.copyWith(favoriteStatus: FavoriteStatus.loading));
    try {
      final myFavoritePosts = await _homeRepository.getMyFavorites();


      for(int i =0; i<myFavoritePosts.length;i++ ){
        myFavoritePosts[i].isFavorite=true;
      }

      emit(state.copyWith(
        favoriteStatus: FavoriteStatus.success,
        myFavoritePosts: myFavoritePosts,
      ));

    } catch (e) {
      emit(state.copyWith(
        favoriteStatus: FavoriteStatus.failure,
        errorMessage: e.toString(),
        posts: [],
      ));
    }

  }

  Future<void> getNewestPosts({int? categoryId}) async{

    emit(state.copyWith(postsStatus: PostsStatus.loading));
    try {
      final posts = await _homeRepository.getNewestPosts(categoryId:categoryId);
      if(categoryId!=null){
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          filterdPosts: posts,
        ));
      }else{
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          posts: posts,
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        postsStatus: PostsStatus.failure,
        errorMessage: e.toString(),
        posts: [],
      ));
    }

  }

  Future<void> getPostsRegions({int? categoryId}) async{
    emit(state.copyWith(postsStatus: PostsStatus.loading));
    String ids='';
    for(int i =0; i< state.selectedRegions.length; i++){
      ids+= '${state.selectedRegions[i].id!.toString()},';
    }

    // List<int?> regionsIds= state.selectedRegions.map(
    //   (e) => e.id,
    // ).toList();
    try {
      final posts = await _homeRepository.getPostsRegions(ids,categoryId:categoryId);
      if(categoryId!=null){
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          filterdPosts: posts,
        ));
      }else{
        emit(state.copyWith(
          postsStatus: PostsStatus.success,
          posts: posts,
        ));
      }

    } catch (e) {
      emit(state.copyWith(
        postsStatus: PostsStatus.failure,
        errorMessage: e.toString(),
        posts: [],
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