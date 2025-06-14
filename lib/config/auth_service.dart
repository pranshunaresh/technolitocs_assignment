import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/home_screen.dart';

class AuthService {
  static const String _accessTokenKey = 'access_token';
  static const String _mobileNumberKey = 'mobile_number';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _profileDataKey = 'profile_data';

  static Future<void> saveLoginCredentials(
    String accessToken,
    String mobileNumber,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_mobileNumberKey, mobileNumber);
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<Map<String, String>?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(_accessTokenKey);
    final mobileNumber = prefs.getString(_mobileNumberKey);
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;

    if (isLoggedIn && accessToken != null && mobileNumber != null) {
      return {'accessToken': accessToken, 'mobileNumber': mobileNumber};
    }
    return null;
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_accessTokenKey);
      await prefs.remove(_mobileNumberKey);
      await prefs.remove(_profileDataKey);
      await prefs.setBool(_isLoggedInKey, false);

      print("logged out from async sharedpref////////");
      Phoenix.rebirth(context);
    } catch (e) {
      print(e);
    }
  }

  /// Save profile JSON string locally
  static Future<void> saveProfileData(Map<String, dynamic> profileJson) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileDataKey, jsonEncode(profileJson));
  }

  /// Get saved profile JSON string
  static Future<Map<String, dynamic>?> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_profileDataKey);
    if (jsonStr != null) {
      return jsonDecode(jsonStr);
    }
    return null;
  }
}
