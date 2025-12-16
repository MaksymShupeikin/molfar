import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigLoader {
  static const String _gistUrl =
      'https://gist.githubusercontent.com/MaksymShupeikin/9c923846c32bb7d51c262dcfea814626/raw/config.json';

  static const String _prefKey = 'saved_api_url';

  static const String _defaultUrl = 'http://localhost:8080';

  static Future<String> getBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await Dio().get(
        _gistUrl,
        options: Options(responseType: ResponseType.plain),
      );

      final Map<String, dynamic> data = jsonDecode(response.data);
      final String? newUrl = data['base_url'];

      if (newUrl != null && newUrl.isNotEmpty) {
        await prefs.setString(_prefKey, newUrl);
        return newUrl;
      }
    } catch (e) {
      throw Exception("Failed to load config from Gist: $e");
    }

    final savedUrl = prefs.getString(_prefKey);
    if (savedUrl != null) {
      return savedUrl;
    }

    return _defaultUrl;
  }
}
