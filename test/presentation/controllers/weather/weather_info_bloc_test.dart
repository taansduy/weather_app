import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';
import 'package:weather/presentation/controllers/weather/weather_info_bloc.dart';

import 'weather_info_bloc_test.mocks.dart';

@GenerateMocks([GetCurrentWeatherUseCase, GetForecastWeatherUseCase])
void main() {
  late WeatherInfoCubit weatherInfoCubit;
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late MockGetForecastWeatherUseCase mockGetForecastWeatherUseCase;

  final testRequest =
      WeatherRequest(lat: 51.5074, lon: -0.1278); // London coordinates
  final testCurrentWeather = CurrentWeatherInfo(
    cityName: 'London',
    celciusTemp: 20,
  );
  final testForecastWeather = [
    ForecastWeatherInfo(
      celciusTemp: 21,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    ForecastWeatherInfo(
      celciusTemp: 19,
      date: DateTime.now().add(const Duration(days: 2)),
    ),
  ];

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    mockGetForecastWeatherUseCase = MockGetForecastWeatherUseCase();

    weatherInfoCubit = WeatherInfoCubit(
      getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase,
      getForecastWeatherUseCase: mockGetForecastWeatherUseCase,
    );
  });

  tearDown(() {
    weatherInfoCubit.close();
  });

  group('WeatherInfoCubit Tests', () {
    test('initial state should be FetchingWeatherInfo', () {
      expect(weatherInfoCubit.state, isA<FetchingWeatherInfo>());
      expect(weatherInfoCubit.state.request, isNull);
    });

    test('updateLocation should update state and trigger fetch', () {
      // Default success stubs
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testCurrentWeather));
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testForecastWeather));
      // Act
      weatherInfoCubit.updateLocation(testRequest.lat, testRequest.lon);

      // Assert
      expect(weatherInfoCubit.state, isA<FetchingWeatherInfo>());
      expect(weatherInfoCubit.state.request?.lat, equals(testRequest.lat));
      expect(weatherInfoCubit.state.request?.lon, equals(testRequest.lon));
    });

    test('fetchWeatherInfo should emit success state when both calls succeed',
        () async {
      // Default success stubs
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testCurrentWeather));
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testForecastWeather));
      // Act
      weatherInfoCubit.updateLocation(testRequest.lat, testRequest.lon);

      // Assert
      await expectLater(
        weatherInfoCubit.stream,
        emitsInOrder([
          isA<FetchWeatherInfoSuccess>()
              .having((s) => s.currentWeatherInfo, 'currentWeatherInfo',
                  equals(testCurrentWeather))
              .having((s) => s.forecastWeatherInfos.length,
                  'forecastWeatherInfos length', equals(2)),
        ]),
      );

      verify(mockGetCurrentWeatherUseCase.call(any)).called(1);
      verify(mockGetForecastWeatherUseCase.call(any)).called(1);
    });

    test(
        'fetchWeatherInfo should emit failure state when current weather call fails',
        () async {
      // Arrange - Override default stub for this test
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure('Error fetching current weather'));

      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure('Error fetching forecast weather'));

      // Act
      weatherInfoCubit.updateLocation(testRequest.lat, testRequest.lon);

      // Assert
      await expectLater(
        weatherInfoCubit.stream,
        emitsInOrder([
          isA<FetchWeatherInfoFailure>().having((s) => s.error, 'error message',
              equals('Something went wrong at our end!')),
        ]),
      );
    });

    test('fetchWeatherInfo should handle empty forecast data', () async {
      // Arrange - Override default stub for this test
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Success([]));
      when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testCurrentWeather));

      // Act
      weatherInfoCubit.updateLocation(testRequest.lat, testRequest.lon);

      // Assert
      await expectLater(
        weatherInfoCubit.stream,
        emitsInOrder([
          isA<FetchWeatherInfoSuccess>()
              .having((s) => s.currentWeatherInfo, 'currentWeatherInfo',
                  equals(testCurrentWeather))
              .having((s) => s.forecastWeatherInfos.length,
                  'forecastWeatherInfos length', equals(0)),
        ]),
      );
    });

    test('fetchWeatherInfo should not emit if request is null', () async {
      // Act
      weatherInfoCubit.fetchWeatherInfo();

      // Assert
      verifyNever(mockGetCurrentWeatherUseCase.call(any));
      verifyNever(mockGetForecastWeatherUseCase.call(any));
    });
  });
}
