import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/data/models/clouds.dart';
import 'package:weather/data/models/wind.dart';
import 'package:weather/data/models/rain.dart';
import 'package:weather/data/models/sys.dart';

void main() {
  group('CurrentWeatherResponse to CurrentWeatherInfo', () {
    test('should map CurrentWeatherResponse to CurrentWeatherInfo correctly', () {
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
        cod: 200,
        weather: [],
      );

      // Act
      final info = response.toCurrentWeatherInfo();

      // Assert
      expect(info, isA<CurrentWeatherInfo>());
      expect(info.cityName, equals('Test City'));
      expect(info.celciusTemp, equals(25.0));
    });

    test('should handle zero temperature', () {
      // Arrange
      final response = CurrentWeatherResposne(
        dt: 1234567890,
        coord: Coord(lat: 10.0, lon: 20.0),
        base: 'stations',
        main: Main(
          temp: 0.0,
          feelsLike: 0.0,
          tempMin: 0.0,
          tempMax: 0.0,
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
        cod: 200,
        weather: [],
      );

      // Act
      final info = response.toCurrentWeatherInfo();

      // Assert
      expect(info.celciusTemp, equals(0.0));
    });
  });
} 