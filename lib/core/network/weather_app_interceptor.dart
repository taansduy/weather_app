import 'package:dio/dio.dart';
import 'package:weather/core/config/app_config.dart';

class WeatherAppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters["appid"] = AppConfig.apiKey;
    super.onRequest(options, handler);
  }
}