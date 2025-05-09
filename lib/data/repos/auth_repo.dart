import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:safqa_app/core/api/api_auth_service.dart';
import 'package:safqa_app/core/services/device_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiAuthService _apiService = ApiAuthService();

  Future<void> _saveAuthData(
      String accessToken, String refreshToken, int expiresInSeconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setInt('token_expiry_time',
        DateTime.now().millisecondsSinceEpoch + (expiresInSeconds * 1000));
  }

  Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final deviceInfo = await DeviceService.getDeviceInfo();
      final response = await _apiService.login({
        'phone_number': phone,
        'password': password,
        'fcm_token': deviceInfo['fcm_token'],
        'device_id': deviceInfo['device_id'],
      });

      print("✅ Login Response: ${response.data}");

      if (response.statusCode == 200) {
        final token = response.data['data']['access_token'];
        final refreshToken = response.data['data']['refresh_token'];
        final expiresIn =
            86400; // 24 ساعة (تأكد من أن السيرفر يرسلها بشكل ثابت)

        if (token != null && refreshToken != null) {
          print("🔹 Saving Token: $token");
          await _saveAuthData(token, refreshToken, expiresIn);
        }
        return {'success': true, 'data': response.data};
      } else {
        return {'success': false, 'message': 'Login failed: ${response.data}'};
      }
    } catch (e) {
      print("❌ Login Error: $e");
      return {'success': false, 'message': 'Login failed: $e'};
    }
  }

  /// ✅ التحقق من التوكن عند تشغيل التطبيق
  Future<bool> initializeAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');
    final expiryTime = prefs.getInt('token_expiry_time');

    if (accessToken != null && expiryTime != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime < expiryTime) {
        // ✅ التوكن صالح
        return true;
      } else {
        // ❌ التوكن منتهي الصلاحية → نحاول تحديثه
        return await _refreshToken();
      }
    }
    return false;
  }

  /// ✅ تحديث التوكن عند انتهاء صلاحيته
  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null) return false;

    try {
      final response = await _apiService.refreshToken();

      if (response!.statusCode == 200) {
        final newAccessToken = response.data['data']['access_token'];
        final newRefreshToken = response.data['data']['refresh_token'];
        final expiresIn = 86400; // 24 ساعة

        if (newAccessToken != null && newRefreshToken != null) {
          await _saveAuthData(newAccessToken, newRefreshToken, expiresIn);
          return true;
        }
      }
    } catch (e) {
      print("❌ Refresh Token Error: $e");
    }

    await logout();
    return false;
  }

  Future<Map<String, dynamic>> register(String name, String phone,
      String password, String confirmPassword) async {
    try {
      final response = await _apiService.register({
        'name': name,
        'phone_number': phone,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      if (response.statusCode == 201) {
        return {'success': true, 'data': response.data};
      } else {
        return {
          'success': false,
          'message': 'Registration failed: ${response.data}'
        };
      }
    } catch (e) {
      print("❌ Registration Error: $e");
      return {'success': false, 'message': 'Registration failed: $e'};
    }
  }

  Future<Map<String, dynamic>> sendOtp(String phone) async {
    try {
      debugPrint("📤 Request Data: $phone");
      final response = await _apiService.post('/v1/auth/otp', data: {
        "phone": phone,
      });
      debugPrint("📥 Response: ${response.data}");

      return response.data;
    } on DioException catch (e) {
      return {"success": false, "message": e.message ?? "فشل في إرسال OTP"};
    }
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String otp,
    required String phoneNumber,
    required String deviceId,
    required String fcmToken,
  }) async {
    try {
      final deviceInfo = await DeviceService.getDeviceInfo();

      final response = await _apiService.post('/api/v1/auth/otp/verify', data: {
        "otp": otp,
        "phone_number": phoneNumber,
        'fcm_token': deviceInfo['fcm_token'],
        'device_id': deviceInfo['device_id'],
      });

      return response.data;
    } on DioException catch (e) {
      return {"success": false, "message": e.message ?? "فشل في التحقق من OTP"};
    }
  }

  /// ❌ تسجيل خروج المستخدم
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
