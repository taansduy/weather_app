import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/data/models/clouds.dart';
import 'package:weather/data/models/wind.dart';
import 'package:weather/data/models/rain.dart';
import 'package:weather/data/models/sys.dart';

void main() {
  group('ForecastWeather', () {
    test('should create ForecastWeather with correct values', () {
      // Arrange
      final main = Main(
        temp: 25.0,
        feelsLike: 26.0,
        tempMin: 24.0,
        tempMax: 27.0,
        pressure: 1013,
        humidity: 80,
        seaLevel: 1013.0,
        grndLevel: 1012.0,
      );
      final weather = [Weather(id: 800, main: 'Clear', description: 'clear sky', icon: '01d')];
      final clouds = Clouds(all: 20);
      final wind = Wind(speed: 5.0, deg: 180, gust: 7.0);
      final rain = Rain(oneHour: 0.0);
      final sys = Sys(
        type: 1,
        id: 1,
        country: 'VN',
        sunrise: 1234567890,
        sunset: 1234567890,
        pod: 'd',
      );

      // Act
      final forecast = ForecastWeather(
        dt: 1234567890,
        main: main,
        weather: weather,
        clouds: clouds,
        wind: wind,
        visibility: 10000,
        pop: 0.0,
        rain: rain,
        sys: sys,
        dtTxt: '2024-03-20 12:00:00',
      );

      // Assert
      expect(forecast.dt, equals(1234567890));
      expect(forecast.main, equals(main));
      expect(forecast.weather, equals(weather));
      expect(forecast.clouds, equals(clouds));
      expect(forecast.wind, equals(wind));
      expect(forecast.visibility, equals(10000));
      expect(forecast.pop, equals(0.0));
      expect(forecast.rain, equals(rain));
      expect(forecast.sys, equals(sys));
      expect(forecast.dtTxt, equals('2024-03-20 12:00:00'));
    });

    test('should create ForecastWeather from JSON', () {
      // Arrange
      final json = {
        'dt': 1234567890,
        'main': {
          'temp': 25.0,
          'feels_like': 26.0,
          'temp_min': 24.0,
          'temp_max': 27.0,
          'pressure': 1013,
          'humidity': 80,
          'sea_level': 1013.0,
          'grnd_level': 1012.0,
        },
        'weather': [
          {
            'id': 800,
            'main': 'Clear',
            'description': 'clear sky',
            'icon': '01d',
          }
        ],
        'clouds': {'all': 20},
        'wind': {'speed': 5.0, 'deg': 180, 'gust': 7.0},
        'visibility': 10000,
        'pop': 0.0,
        'rain': {'1h': 0.0},
        'sys': {
          'type': 1,
          'id': 1,
          'country': 'VN',
          'sunrise': 1234567890,
          'sunset': 1234567890,
          'pod': 'd',
        },
        'dt_txt': '2024-03-20 12:00:00',
      };

      // Act
      final forecast = ForecastWeather.fromJson(json);

      // Assert
      expect(forecast.dt, equals(1234567890));
      expect(forecast.main.temp, equals(25.0));
      expect(forecast.weather.length, equals(1));
      expect(forecast.weather[0].id, equals(800));
      expect(forecast.clouds.all, equals(20));
      expect(forecast.wind.speed, equals(5.0));
      expect(forecast.visibility, equals(10000));
      expect(forecast.pop, equals(0.0));
      expect(forecast.rain.oneHour, equals(0.0));
      expect(forecast.sys.country, equals('VN'));
      expect(forecast.dtTxt, equals('2024-03-20 12:00:00'));
    });
  });

  group('ForecastWeatherResponse', () {
    test('should create ForecastWeatherResponse with correct values', () {
      // Arrange
      final forecast = ForecastWeather(
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
        weather: [Weather(id: 800, main: 'Clear', description: 'clear sky', icon: '01d')],
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
      );

      // Act
      final response = ForecastWeatherResponse(
        cod: 200,
        message: '',
        cnt: 1,
        list: [forecast],
      );

      // Assert
      expect(response.cod, equals(200));
      expect(response.message, equals(''));
      expect(response.cnt, equals(1));
      expect(response.list, equals([forecast]));
    });

    test('should create ForecastWeatherResponse from JSON', () {
      // Arrange
      final json = {
        'cod': 200,
        'message': '',
        'cnt': 1,
        'list': [
          {
            'dt': 1234567890,
            'main': {
              'temp': 25.0,
              'feels_like': 26.0,
              'temp_min': 24.0,
              'temp_max': 27.0,
              'pressure': 1013,
              'humidity': 80,
              'sea_level': 1013.0,
              'grnd_level': 1012.0,
            },
            'weather': [
              {
                'id': 800,
                'main': 'Clear',
                'description': 'clear sky',
                'icon': '01d',
              }
            ],
            'clouds': {'all': 20},
            'wind': {'speed': 5.0, 'deg': 180, 'gust': 7.0},
            'visibility': 10000,
            'pop': 0.0,
            'rain': {'1h': 0.0},
            'sys': {
              'type': 1,
              'id': 1,
              'country': 'VN',
              'sunrise': 1234567890,
              'sunset': 1234567890,
              'pod': 'd',
            },
            'dt_txt': '2024-03-20 12:00:00',
          }
        ],
      };

      // Act
      final response = ForecastWeatherResponse.fromJson(json);

      // Assert
      expect(response.cod, equals(200));
      expect(response.message, equals(''));
      expect(response.cnt, equals(1));
      expect(response.list.length, equals(1));
      expect(response.list[0].dt, equals(1234567890));
      expect(response.list[0].main.temp, equals(25.0));
      expect(response.list[0].weather[0].id, equals(800));
    });
  });
} 