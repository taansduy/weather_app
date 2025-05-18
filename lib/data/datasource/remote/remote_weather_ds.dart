import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/data/models/weather_request.dart';

abstract class WeatherDataSource {
   Future<CurrentWeatherResposne> getCurrentWeather(WeatherRequest request);
   Future<ForecastWeatherResponse> getForecastWeather(WeatherRequest request);
}

class RemoteWeatherDataSource extends WeatherDataSource {
  final BaseDioClient _dioClient;

  RemoteWeatherDataSource({required BaseDioClient dioClient}): _dioClient = dioClient;

  @override
  Future<CurrentWeatherResposne> getCurrentWeather(WeatherRequest request) async {
    try {
      final response = await _dioClient.get(ApiPath.currentWeatherData, queryParams: request.toMap());
      return CurrentWeatherResposne.fromJson(response.data);
    } catch (e) {
      throw "Something went wrong at our end!";
    }
  }
  
  @override
  Future<ForecastWeatherResponse> getForecastWeather(WeatherRequest request) async  {
    try {
      final response = await _dioClient.get(ApiPath.forecastWeather, queryParams: request.toMap());
      return ForecastWeatherResponse.fromJson(response.data);
    } catch (e) {
      throw "Something went wrong at our end!";
    }
  }
}
