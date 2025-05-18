import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/utils/date_ext.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherDataSource _weatherDataSource;

  WeatherRepositoryImpl({required WeatherDataSource weatherDataSource})
      : _weatherDataSource = weatherDataSource;

  @override
  Future<Result<CurrentWeatherInfo>> getCurrentWeatherInfo(WeatherRequest request) async {
    try {
      var response = await _weatherDataSource.getCurrentWeather(request);
      if (response.cod == ResponseCode.success) {
        return Result<CurrentWeatherInfo>.success(response.toCurrentWeatherInfo());
      }
      return Result<CurrentWeatherInfo>.failed("Something went wrong at our end!");
    } catch (e) {
      return Result<CurrentWeatherInfo>.failed("Something went wrong at our end!");
    }
  }

  @override
  Future<Result<List<ForecastWeatherInfo>>> getForecastWeatherInfos(
      WeatherRequest request) async {
    try {
      var response = await _weatherDataSource.getForecastWeather(request);
      if (response.cod == ResponseCode.success) {
        Map<DateTime,List<double>> forecastWeatherByDate= {};
        for (var forecastWeather in response.list) {
          var date = DateTime.fromMillisecondsSinceEpoch(forecastWeather.dt * 1000).subtract(vnTimeZoneOffset).removeTime();
          if (forecastWeatherByDate.containsKey(date)) {
            forecastWeatherByDate[date]?.add(forecastWeather.main.temp);
          } else {
            forecastWeatherByDate[date] = [forecastWeather.main.temp];
          }
        }
        var forecastWeatherInfos = forecastWeatherByDate.entries.map((e) => ForecastWeatherInfo(date: e.key, celciusTemp: e.value.reduce((a, b) => a + b) / e.value.length)).toList();
        return Result<List<ForecastWeatherInfo>>.success(forecastWeatherInfos);
      }
      return Result<List<ForecastWeatherInfo>>.failed("Something went wrong at our end!");
    } catch (e) {
      print(e);
      return Result<List<ForecastWeatherInfo>>.failed("Something went wrong at our end!");
    }
  }
}
