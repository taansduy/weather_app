import 'package:weather/core/utils/result.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource _weatherDataSource;

  WeatherRepositoryImpl({required WeatherDataSource weatherDataSource}): _weatherDataSource = weatherDataSource;

  @override
  Future<Result<CurrentWeatherInfo>> getCurrentWeatherInfo(WeatherRequest request) async {
   var _weatherInfo = await _weatherDataSource.getCurrentForecastWeather();
   return Result<CurrentWeatherInfo>.success(CurrentWeatherInfo(
    name: "",
   celciusTemp: 100
   ));
  }

  @override
  Future<Result<List<ForecastWeatherInfo>>> getForecastWeatherInfos(WeatherRequest request) async {
      return Result<List<ForecastWeatherInfo>>.success([]);
  }
}
