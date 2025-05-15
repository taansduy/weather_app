import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class GetForecastWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetForecastWeatherUseCase({required WeatherRepository weatherRepository}): _weatherRepository = weatherRepository;

  Future<Result<List<ForecastWeatherInfo>>> call(WeatherRequest request) async {
    return await _weatherRepository.getForecastWeatherInfos(request);
  }
}
