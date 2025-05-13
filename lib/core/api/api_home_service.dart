import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:safqa_app/core/api/api_constants.dart';
import 'package:safqa_app/data/models/category_model.dart';
import 'package:safqa_app/data/models/city_model.dart';
import 'package:safqa_app/data/models/post_model.dart';
import 'package:safqa_app/data/models/sub_category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiHomeService {
  final Dio _dio;

  ApiHomeService()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
            headers: {'Content-Type': 'application/json'},

          ),
        ) {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final refreshResponse =
                await refreshToken(); // هنا نقوم بتخزين نتيجة التحديث

            if (refreshResponse != null) {
              // التحقق مما إذا كان هناك استجابة
              return handler.resolve(await _retryRequest(e.requestOptions));
            }
          }
          return handler.reject(_handleError(e));
        },
      ),
      LogInterceptor(
          request: true, requestBody: true, responseBody: true, error: true,),
    ]);
  }

  //get categories

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/v1/categories');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((category) => CategoryModel.fromJson(category)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }


  Future<List<PostModel>> getHomePosts({int? categoryId}) async {
    try {
      final Response<dynamic>  response;
      if(categoryId !=null){
     response = await _dio.get('${ApiConstants.baseHomePosts}&&filter[category_id]=$categoryId');
      }else{

      response = await _dio.get(ApiConstants.baseHomePosts);
      }
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }



  Future<List<PostModel>> getPostsByRegionId({int? regionId}) async {
    try {
      final response = await _dio.get('${ApiConstants.baseHomePosts}&&filter[region_id]=$regionId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }

  Future<List<PostModel>> getNewestPosts({int? categoryId}) async {
    try {
      final Response<dynamic> response;
      if(categoryId !=null){
       response = await _dio.get('${ApiConstants.baseHomePosts}&&sort=-id&&filter[category_id]=$categoryId');
      }else{
       response = await _dio.get('${ApiConstants.baseHomePosts}&&sort=-id');
      }
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }

  Future<List<PostModel>> getPostsRegions(String regionsIds,{int? categoryId}) async {

    try {
      final Response<dynamic> response;
      if(categoryId !=null){
        response =await _dio.get('${ApiConstants.baseHomePosts}&&filter[category_id]=$categoryId&&filter[region_id]=$regionsIds');
      }else{
         response = await _dio.get('${ApiConstants.baseHomePosts}&&filter[region_id]=$regionsIds');
      }
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((post) => PostModel.fromJson(post)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }

  // get details category

  Future <List<CategoryModel>> getDetailsCategory(int parentId) async {
    try {
      final response = await _dio.get('/v1/categories?filter[parent_id]=$parentId');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        return data.map((category) => CategoryModel.fromJson(category)).toList();

      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }
  // Future<List<SubCategoryModel>> getSubCategories() async {
  //   try {
  //     final response = await _dio.get('/v1/categories/');
  //     if (response.statusCode == 200) {
  //       final data = response.data['data'];
  //       SubCategoryModel.fromJson(data);
  //       // return data.map((subCategory) => SubCategoryModel.fromJson(subCategory)).toList();
  //     } else {
  //       throw Exception('Failed to load categories');
  //     }
  //   } catch (e) {
  //     print("❌ Error fetching categories: $e");
  //     return [];
  //   }
  // }


  Future<List<CityModel>> getCities() async {
    try {
      final response = await _dio.get('/v1/cities');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((city) => CityModel.fromJson(city)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print("❌ Error fetching categories: $e");
      return [];
    }
  }


  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> _getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<Response?> refreshToken() async {
    final refreshToken = await _getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post(
        '/api/v1/auth/token/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['data']['access_token'];
        final newRefreshToken = response.data['data']['refresh_token'];

        if (newAccessToken != null && newRefreshToken != null) {
          await _saveTokens(newAccessToken, newRefreshToken);
          return response;
        }
      }
    } catch (e) {
      print("❌ Error refreshing token: $e");
    }
    return null;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final newToken = await _getAccessToken();
    if (newToken == null)
      throw DioException(
          requestOptions: requestOptions, error: "Token is null");

    final options = Options(
      method: requestOptions.method,
      headers: {...requestOptions.headers, 'Authorization': 'Bearer $newToken'},
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  DioException _handleError(DioException e) {
    String errorMessage = 'Request failed';

    if (e.response != null && e.response?.data is Map<String, dynamic>) {
      final data = e.response?.data;
      if (data != null && data.containsKey('message')) {
        errorMessage = data['message'].toString();
      }
    } else if (e.message != null) {
      errorMessage = e.message!;
    }

    return DioException(
      requestOptions: e.requestOptions,
      response: e.response,
      type: e.type,
      error: errorMessage,
    );
  }
}
