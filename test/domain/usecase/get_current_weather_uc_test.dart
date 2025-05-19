import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';


class MockWeatherRepository extends Mock implements WeatherRepository {
  @override
  Future<Result<CurrentWeatherInfo>> getCurrentWeatherInfo(WeatherRequest request) async {
    return super.noSuchMethod(
      Invocation.method(#getCurrentWeatherInfo, [request]),
      returnValue: Future.value(Result.success(CurrentWeatherInfo(cityName: 'Test City', celciusTemp: 25.0))),
    ) as Future<Result<CurrentWeatherInfo>>;
  }

  @override
  Future<Result<List<ForecastWeatherInfo>>> getForecastWeatherInfos(WeatherRequest request) async {
    return super.noSuchMethod(
      Invocation.method(#getForecastWeatherInfos, [request]),
      returnValue: Future.value(Result.success(<ForecastWeatherInfo>[])),
    ) as Future<Result<List<ForecastWeatherInfo>>>;
  }
}

void main() {
  late GetCurrentWeatherUseCase useCase;
  late MockWeatherRepository mockRepository;

  setUp(() {
    mockRepository = MockWeatherRepository();
    useCase = GetCurrentWeatherUseCase(weatherRepository: mockRepository);
  });

  group('call', () {
    final request = WeatherRequest(lat: 10.0, lon: 20.0);
    final weatherInfo = CurrentWeatherInfo(cityName: 'Test City', celciusTemp: 25.0);

    test('should return success with CurrentWeatherInfo when repository returns success', () async {
      // Arrange
      when(mockRepository.getCurrentWeatherInfo(request))
          .thenAnswer((_) async => Result.success(weatherInfo));

      // Act
      final result = await useCase.call(request);

      // Assert
      expect(result, isA<Result<CurrentWeatherInfo>>());
      expect(result is Success, isTrue);
      expect((result as Success).data, equals(weatherInfo));
      verify(mockRepository.getCurrentWeatherInfo(request)).called(1);
    });

    test('should return failure when repository returns failure', () async {
      // Arrange
      const error = 'Something went wrong';
      when(mockRepository.getCurrentWeatherInfo(request))
          .thenAnswer((_) async => Result.failed(error));

      // Act
      final result = await useCase.call(request);

      // Assert
      expect(result, isA<Result<CurrentWeatherInfo>>());
      expect(result is Failure, isTrue);
      expect((result as Failure).error, equals(error));
      verify(mockRepository.getCurrentWeatherInfo(request)).called(1);
    });
  });
} 