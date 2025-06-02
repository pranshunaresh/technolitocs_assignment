import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  // Base API URL
  static const String baseUrl = "https://api.rolbol.org/api/v1";

  // Base S3 image URL
  static const String baseImageUrl =
      "https://technolitics-s3-bucket.s3.ap-south-1.amazonaws.com/rolbol-s3-bucket/";

  /// Returns standard headers including Authorization token if available.
  static Future<Map<String, String>> get headers async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');

    if (accessToken?.isNotEmpty != true) {
      return {'Content-Type': 'application/json'};
    }

    return {'Content-Type': 'application/json'};
  }
}
