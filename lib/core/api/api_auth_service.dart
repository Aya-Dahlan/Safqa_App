import 'package:dio/dio.dart';
import 'package:safqa_app/core/api/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiAuthService {
  final Dio _dio;

  ApiAuthService()
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
          request: true, requestBody: true, responseBody: true, error: true),
    ]);
  }
  Future<Response<dynamic>> login(Map<String, dynamic> data) async {
    return await _dio.post('/v1/auth/token', data: data);
  }

  Future<Response<dynamic>> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    return await _dio.post(
      endpoint,
      data: data,
      options: Options(
        headers: {"Content-Type": "application/json"},
      ),
    );
  }

  Future<Response<dynamic>> register(Map<String, dynamic> data) async {
    return await _dio.post('/v1/auth/register', data: data);
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
        '/v1/auth/token/refresh',
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
