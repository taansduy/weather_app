import 'package:dio/dio.dart';
import 'package:weather/core/config/app_config.dart';
import 'package:weather/core/constants/api_constants.dart';

class WeatherAppInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters[ApiParams.APP_ID] = AppConfig.apiKey;
    options.queryParameters[ApiParams.UNITS] = "metric";
    super.onRequest(options, handler);
  }
}