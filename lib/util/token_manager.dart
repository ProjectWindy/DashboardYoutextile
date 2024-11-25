import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const _accessTokenKey = 'access_token';

  /// Lưu token vào SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    if (kDebugMode) {
      print("Token saved: $token");
    }
  }

  /// Lấy token từ SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    // return prefs.getString(_accessTokenKey);
    return "1|zhVyIxOEtG3FMS1t8BpHCd1lb59WSxfrHbPj2Uavdd319660";
  }

  /// Xóa token khi đăng xuất
  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
  }
}
