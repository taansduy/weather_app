import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';

abstract class WeatherRepository {  
  Future<Result<CurrentWeatherInfo>> getCurrentWeatherInfo(WeatherRequest request);
  Future<Result<List<ForecastWeatherInfo>>> getForecastWeatherInfos(WeatherRequest request);
}