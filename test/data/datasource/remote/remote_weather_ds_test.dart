import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/forecast_weather_response.dart';
import 'package:weather/data/models/weather_request.dart';

class MockBaseDioClient extends Mock implements BaseDioClient {
  @override
  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    return super.noSuchMethod(
      Invocation.method(#get, [path], {#queryParams: queryParams}),
      returnValue: Future.value(Response<T>(
        data: {} as T,
        statusCode: 200,
        requestOptions: RequestOptions(path: path),
      )),
    ) as Future<Response<T>>;
  }
}

void main() {
  late MockBaseDioClient mockDioClient;
  late RemoteWeatherDataSource dataSource;
  late WeatherRequest testRequest;

  setUp(() {
    mockDioClient = MockBaseDioClient();
    dataSource = RemoteWeatherDataSource(dioClient: mockDioClient);
    testRequest = WeatherRequest(lat: 10.0, lon: 20.0);
  });

  group('getCurrentWeather', () {
    test('should return CurrentWeatherResponse when API call is successful', () async {
      // Arrange
      final mockResponse = Response(
        data: {
          'dt': 1234567890,
          'coord': {'lat': 10.0, 'lon': 20.0},
          'base': 'stations',
          'main': {
            'temp': 25.0,
            'feels_like': 26.0,
            'temp_min': 24.0,
            'temp_max': 27.0,
            'pressure': 1013,
            'humidity': 80,
            'sea_level': 1013,
            'grnd_level': 1012
          },
          'visibility': 10000,
          'wind': {'speed': 5.0, 'deg': 180, 'gust': 7.0},
          'rain': {'1h': 0.0, '3h': 0.0},
          'clouds': {'all': 20},
          'sys': {
            'type': 1,
            'id': 1,
            'country': 'VN',
            'sunrise': 1234567890,
            'sunset': 1234567890
          },
          'name': 'Test City',
          'timezone': 25200,
          'cod': ResponseCode.success,
          'weather': [
            {
              'id': 800,
              'main': 'Clear',
              'description': 'clear sky',
              'icon': '01d'
            }
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDioClient.get(ApiPath.currentWeatherData, queryParams: testRequest.toMap()))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.getCurrentWeather(testRequest);

      // Assert
      expect(result, isA<CurrentWeatherResposne>());
      expect(result.name, 'Test City');
      expect(result.main.temp, 25.0);
      verify(mockDioClient.get(ApiPath.currentWeatherData, queryParams: testRequest.toMap())).called(1);
    });

    test('should throw error when API call fails', () async {
      // Arrange
      when(mockDioClient.get(ApiPath.currentWeatherData, queryParams: testRequest.toMap()))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      // Act & Assert
      expect(
        () => dataSource.getCurrentWeather(testRequest),
        throwsA('Something went wrong at our end!'),
      );
      verify(mockDioClient.get(ApiPath.currentWeatherData, queryParams: testRequest.toMap())).called(1);
    });
  });

  group('getForecastWeather', () {
    test('should return ForecastWeatherResponse when API call is successful', () async {
      // Arrange
      final mockResponse = Response(
        data: {
          'cod': ResponseCode.success,
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
                'sea_level': 1013,
                'grnd_level': 1012
              },
              'weather': [
                {
                  'id': 800,
                  'main': 'Clear',
                  'description': 'clear sky',
                  'icon': '01d'
                }
              ],
              'clouds': {'all': 20},
              'wind': {'speed': 5.0, 'deg': 180, 'gust': 7.0},
              'visibility': 10000,
              'pop': 0.0,
              'rain': {'1h': 0.0, '3h': 0.0},
              'sys': {
                'type': 1,
                'id': 1,
                'country': 'VN',
                'sunrise': 1234567890,
                'sunset': 1234567890
              },
              'dt_txt': '2024-03-20 12:00:00'
            }
          ]
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDioClient.get(ApiPath.forecastWeather, queryParams: testRequest.toMap()))
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await dataSource.getForecastWeather(testRequest);

      // Assert
      expect(result, isA<ForecastWeatherResponse>());
      expect(result.cod, ResponseCode.success);
      expect(result.list.length, 1);
      expect(result.list[0].main.temp, 25.0);
      verify(mockDioClient.get(ApiPath.forecastWeather, queryParams: testRequest.toMap())).called(1);
    });

    test('should throw error when API call fails', () async {
      // Arrange
      when(mockDioClient.get(ApiPath.forecastWeather, queryParams: testRequest.toMap()))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));

      // Act & Assert
      expect(
        () => dataSource.getForecastWeather(testRequest),
        throwsA('Something went wrong at our end!'),
      );
      verify(mockDioClient.get(ApiPath.forecastWeather, queryParams: testRequest.toMap())).called(1);
    });
  });
} 