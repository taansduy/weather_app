import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:weather/core/network/weather_app_dio_client.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late WeatherAppDioClient dioClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dioClient = WeatherAppDioClient();
  });

  group('WeatherAppDioClient Tests', () {
    test('should initialize with correct base URL', () {
      expect(dioClient.dio.options.baseUrl, isNotEmpty);
    });

    test('should have correct headers', () {
      expect(dioClient.dio.options.headers, isNotEmpty);
      expect(dioClient.dio.options.headers['Content-Type'], 'application/json');
    });

    test('should handle GET request successfully', () async {
      // Arrange
      const testUrl = '/test';
      const testResponse = {'data': 'test'};
      
      when(mockDio.get(testUrl)).thenAnswer(
        (_) async => Response(
          data: testResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: testUrl),
        ),
      );

      // Act
      final response = await dioClient.get(testUrl);

      // Assert
      expect(response, isNotNull);
      expect(response.statusCode, 200);
    });

    test('should handle error response', () async {
      // Arrange
      const testUrl = '/test';
      
      when(mockDio.get(testUrl)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: testUrl),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: testUrl),
          ),
        ),
      );

      // Act & Assert
      expect(
        () => dioClient.get(testUrl),
        throwsA(isA<DioException>()),
      );
    });
  });
} 