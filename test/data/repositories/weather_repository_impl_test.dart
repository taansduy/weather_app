import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/models/clouds.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/data/models/rain.dart';
import 'package:weather/data/models/sys.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/data/models/wind.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';

class MockWeatherDataSource extends Mock implements WeatherDataSource {
  @override
  Future<CurrentWeatherResposne> getCurrentWeather(WeatherRequest request) async {
    return super.noSuchMethod(
      Invocation.method(#getCurrentWeather, [request]),
      returnValue: Future.value(CurrentWeatherResposne(
        dt: 1234567890,
        coord: Coord(lat: 10.0, lon: 20.0),
        base: 'stations',
        main: Main(
          temp: 25.0,
          feelsLike: 26.0,
          tempMin: 24.0,
          tempMax: 27.0,
          pressure: 1013,
          humidity: 80,
          seaLevel: 1013.0,
          grndLevel: 1012.0,
        ),
        visibility: 10000,
        wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
        rain: Rain(oneHour: 0.0),
        clouds: Clouds(all: 20),
        sys: Sys(
          type: 1,
          id: 1,
          country: 'VN',
          sunrise: 1234567890,
          sunset: 1234567890,
          pod: 'd',
        ),
        name: 'Test City',
        timezone: 25200,
        cod: ResponseCode.success,
        weather: [],
      )),
    ) as Future<CurrentWeatherResposne>;
  }

  @override
  Future<ForecastWeatherResponse> getForecastWeather(WeatherRequest request) async {
    return super.noSuchMethod(
      Invocation.method(#getForecastWeather, [request]),
      returnValue: Future.value(ForecastWeatherResponse(
        cod: ResponseCode.success,
        message: '0',
        cnt: 2,
        list: [
          ForecastWeather(
            dt: 1234567890,
            main: Main(
              temp: 25.0,
              feelsLike: 26.0,
              tempMin: 24.0,
              tempMax: 27.0,
              pressure: 1013,
              humidity: 80,
              seaLevel: 1013.0,
              grndLevel: 1012.0,
            ),
            weather: [],
            clouds: Clouds(all: 20),
            wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
            visibility: 10000,
            pop: 0.0,
            rain: Rain(oneHour: 0.0),
            sys: Sys(
              type: 1,
              id: 1,
              country: 'VN',
              sunrise: 1234567890,
              sunset: 1234567890,
              pod: 'd',
            ),
            dtTxt: '2024-03-20 12:00:00',
          ),
        ],
      )),
    ) as Future<ForecastWeatherResponse>;
  }
}

void main() {
  late WeatherRepositoryImpl repository;
  late MockWeatherDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockWeatherDataSource();
    repository = WeatherRepositoryImpl(weatherDataSource: mockDataSource);
  });

  group('getCurrentWeatherInfo', () {
    final request = WeatherRequest(lat: 10.0, lon: 20.0);

    test('should return success with CurrentWeatherInfo when API call is successful', () async {
      // Arrange
      final response = CurrentWeatherResposne(
        dt: 1234567890,
        coord: Coord(lat: 10.0, lon: 20.0),
        base: 'stations',
        main: Main(
          temp: 25.0,
          feelsLike: 26.0,
          tempMin: 24.0,
          tempMax: 27.0,
          pressure: 1013,
          humidity: 80,
          seaLevel: 1013.0,
          grndLevel: 1012.0,
        ),
        visibility: 10000,
        wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
        rain: Rain(oneHour: 0.0),
        clouds: Clouds(all: 20),
        sys: Sys(
          type: 1,
          id: 1,
          country: 'VN',
          sunrise: 1234567890,
          sunset: 1234567890,
          pod: 'd',
        ),
        name: 'Test City',
        timezone: 25200,
        cod: ResponseCode.success,
        weather: [],
      );

      when(mockDataSource.getCurrentWeather(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.getCurrentWeatherInfo(request);

      // Assert
      expect(result, isA<Result<CurrentWeatherInfo>>());
      expect(result is Success, isTrue);
      expect((result as Success).data, isA<CurrentWeatherInfo>());
      expect((result as Success).data.cityName, equals('Test City'));
      expect((result as Success).data.celciusTemp, equals(25.0));
      verify(mockDataSource.getCurrentWeather(request)).called(1);
    });

    test('should return failure when API call returns error code', () async {
      // Arrange
      final response = CurrentWeatherResposne(
        dt: 1234567890,
        coord: Coord(lat: 10.0, lon: 20.0),
        base: 'stations',
        main: Main(
          temp: 25.0,
          feelsLike: 26.0,
          tempMin: 24.0,
          tempMax: 27.0,
          pressure: 1013,
          humidity: 80,
          seaLevel: 1013.0,
          grndLevel: 1012.0,
        ),
        visibility: 10000,
        wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
        rain: Rain(oneHour: 0.0),
        clouds: Clouds(all: 20),
        sys: Sys(
          type: 1,
          id: 1,
          country: 'VN',
          sunrise: 1234567890,
          sunset: 1234567890,
          pod: 'd',
        ),
        name: 'Test City',
        timezone: 25200,
        cod: 100,
        weather: [],
      );

      when(mockDataSource.getCurrentWeather(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.getCurrentWeatherInfo(request);

      // Assert
      expect(result, isA<Result<CurrentWeatherInfo>>());
      expect(result is Failure, isTrue);
      expect((result as Failure).error, equals('Something went wrong at our end!'));
      verify(mockDataSource.getCurrentWeather(request)).called(1);
    });

    test('should return failure when API call throws exception', () async {
      // Arrange
      when(mockDataSource.getCurrentWeather(request))
          .thenThrow(Exception('Network error'));

      // Act
      final result = await repository.getCurrentWeatherInfo(request);

      // Assert
      expect(result, isA<Result<CurrentWeatherInfo>>());
      expect(result is Failure, isTrue);
      expect((result as Failure).error, equals('Something went wrong at our end!'));
      verify(mockDataSource.getCurrentWeather(request)).called(1);
    });
  });

  group('getForecastWeatherInfos', () {
    final request = WeatherRequest(lat: 10.0, lon: 20.0);

    test('should return success with ForecastWeatherInfo list when API call is successful', () async {
      // Arrange
      final response = ForecastWeatherResponse(
        cod: ResponseCode.success,
        message: '0',
        cnt: 2,
        list: [
          ForecastWeather(
            dt: 1234567890,
            main: Main(
              temp: 25.0,
              feelsLike: 26.0,
              tempMin: 24.0,
              tempMax: 27.0,
              pressure: 1013,
              humidity: 80,
              seaLevel: 1013.0,
              grndLevel: 1012.0,
            ),
            weather: [],
            clouds: Clouds(all: 20),
            wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
            visibility: 10000,
            pop: 0.0,
            rain: Rain(oneHour: 0.0),
            sys: Sys(
              type: 1,
              id: 1,
              country: 'VN',
              sunrise: 1234567890,
              sunset: 1234567890,
              pod: 'd',
            ),
            dtTxt: '2024-03-20 12:00:00',
          ),
          ForecastWeather(
            dt: 1234567890 + 86400, // Next day
            main: Main(
              temp: 26.0,
              feelsLike: 27.0,
              tempMin: 25.0,
              tempMax: 28.0,
              pressure: 1013,
              humidity: 80,
              seaLevel: 1013.0,
              grndLevel: 1012.0,
            ),
            weather: [],
            clouds: Clouds(all: 20),
            wind: Wind(speed: 5.0, deg: 180, gust: 7.0),
            visibility: 10000,
            pop: 0.0,
            rain: Rain(oneHour: 0.0),
            sys: Sys(
              type: 1,
              id: 1,
              country: 'VN',
              sunrise: 1234567890,
              sunset: 1234567890,
              pod: 'd',
            ),
            dtTxt: '2024-03-21 12:00:00',
          ),
        ],
      );

      when(mockDataSource.getForecastWeather(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.getForecastWeatherInfos(request);

      // Assert
      expect(result, isA<Result<List<ForecastWeatherInfo>>>());
      expect(result is Success, isTrue);
      expect((result as Success).data, isA<List<ForecastWeatherInfo>>());
      expect((result as Success).data?.length, equals(2));
      expect((result as Success).data?[0].celciusTemp, equals(25.0));
      expect((result as Success).data?[1].celciusTemp, equals(26.0));
      verify(mockDataSource.getForecastWeather(request)).called(1);
    });

    test('should return failure when API call returns error code', () async {
      // Arrange
      final response = ForecastWeatherResponse(
        cod: 100,
        message: '0',
        cnt: 0,
        list: [],
      );

      when(mockDataSource.getForecastWeather(request))
          .thenAnswer((_) async => response);

      // Act
      final result = await repository.getForecastWeatherInfos(request);

      // Assert
      expect(result, isA<Result<List<ForecastWeatherInfo>>>());
      expect(result is Success, isFalse);
      expect((result as Failure).error, equals('Something went wrong at our end!'));
      verify(mockDataSource.getForecastWeather(request)).called(1);
    });

    test('should return failure when API call throws exception', () async {
      // Arrange
      when(mockDataSource.getForecastWeather(request))
          .thenThrow(Exception('Network error'));

      // Act
      final result = await repository.getForecastWeatherInfos(request);

      // Assert
      expect(result, isA<Result<List<ForecastWeatherInfo>>>());
      expect(result is Failure, isTrue);
      expect((result as Failure).error, equals('Something went wrong at our end!'));
      verify(mockDataSource.getForecastWeather(request)).called(1);
    });
  });
} 