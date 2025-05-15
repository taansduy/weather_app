import 'package:dio/dio.dart';
import 'package:weather/core/config/app_config.dart';
import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/core/network/weather_app_interceptor.dart';
class WeatherAppDioClient extends BaseDioClient {

  WeatherAppDioClient() : super(AppConfig.baseUrl,interceptors: [WeatherAppInterceptor()]);

}
