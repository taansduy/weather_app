import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/core/constants/constants.dart';
import 'package:weather/core/utils/map_ext.dart';

class AppConfig {
  static late final String _apiKey;
  static late final String _baseUrl;
  static bool _initialized = false;

  static void init() {
    if (!_initialized) {
      _apiKey = dotenv.env.parseString(AppConfigConstants.API_KEY);
      _baseUrl = dotenv.env.parseString(AppConfigConstants.BASE_URL);
      _initialized = true;
    } 
  }

  static String get baseUrl {
    assert(_initialized, 'AppConfig.init() must be called before accessing baseUrl');
    return _baseUrl;
  }

  static String get apiKey {
    assert(_initialized, 'AppConfig.init() must be called before accessing apiKey');
    return _apiKey;
  }
}
