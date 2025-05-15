import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/data/models/current_forecast_weather.dart';

abstract class WeatherDataSource {
   Future<void> getCurrentForecastWeather();
}

class RemoteWeatherDataSource extends WeatherDataSource {
  final BaseDioClient _dioClient;

  RemoteWeatherDataSource({required BaseDioClient dioClient}): _dioClient = dioClient;

  @override
  Future<void> getCurrentForecastWeather() async {

  }
}
