import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceService {
  static Future<Map<String, String?>> getDeviceInfo() async {
    try {
      String? fcmToken = await FirebaseMessaging.instance.getToken();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? deviceId;

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor;
      }

      return {
        'fcm_token': fcmToken,
        'device_id': deviceId,
      };
    } catch (e) {
      print("Error getting device info: $e");
      return {
        'fcm_token': null,
        'device_id': null,
      };
    }
  }
}
