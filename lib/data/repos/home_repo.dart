import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:safqa_app/core/api/api_auth_service.dart';
import 'package:safqa_app/core/api/api_home_service.dart';
import 'package:safqa_app/core/services/device_service.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/city_model.dart';
import 'package:safqa_app/data/models/sub_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final ApiHomeService _apiService = ApiHomeService();


  //get categories


  Future<List<CategoryModel>> getCategories() async {
      try {
        return _apiService.getCategories();


      } catch (e) {
        debugPrint("❌ Error fetching categories: $e");
        return [];
      }
    }


    // get details category

  Future <List<CategoryModel>> getDetailsCategory(int parentId) async {
    try {
      final response = await _apiService.getDetailsCategory(parentId);
      return response;
    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      return [];
    }
  }
  Future<List<CityModel>> getCities() async {
    try {
      final response = await _apiService.getCities();
      return response;


    } catch (e) {
      debugPrint("❌ Error fetching categories: $e");
      return [];
    }
  }



  // Future<List<SubCategoryModel>> getSubCategory() async {
  //   try {
  //     final response = await _apiService.getSubCategory();
  //     return response;
  //
  //
  //   } catch (e) {
  //     debugPrint("❌ Error fetching categories: $e");
  //     return [];
  //   }
  // }

}
