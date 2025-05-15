import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository _weatherRepository;

  GetCurrentWeatherUseCase({required WeatherRepository weatherRepository}): _weatherRepository = weatherRepository;

  Future<Result<CurrentWeatherInfo>> call(WeatherRequest request) async {
    return await _weatherRepository.getCurrentWeatherInfo(request);
  }
}
