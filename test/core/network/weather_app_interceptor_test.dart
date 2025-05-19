import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/config/app_config.dart';
import 'package:weather/core/constants/api_constants.dart';
import 'package:weather/core/network/weather_app_interceptor.dart';

void main() {
  group('WeatherAppInterceptor', () {
    late WeatherAppInterceptor interceptor;
    late RequestOptions requestOptions;
    late RequestInterceptorHandler handler;

    setUp(() async {
      await dotenv.load(fileName: '.env');
      AppConfig.init();
      interceptor = WeatherAppInterceptor();
      requestOptions = RequestOptions(
        path: '/test',
        method: 'GET',
        queryParameters: {},
      );
      handler = RequestInterceptorHandler();
    });

    test('should add app_id and units to query parameters', () {
      // Arrange
      final expectedParams = {
        ApiParams.APP_ID: AppConfig.apiKey,
        ApiParams.UNITS: 'metric',
      };

      // Act
      interceptor.onRequest(requestOptions, handler);

      // Assert
      expect(requestOptions.queryParameters, equals(expectedParams));
    });

    test('should preserve existing query parameters', () {
      // Arrange
      final existingParams = {'existing': 'param'};
      requestOptions.queryParameters = Map.from(existingParams);
      final expectedParams = {
        ...existingParams,
        ApiParams.APP_ID: AppConfig.apiKey,
        ApiParams.UNITS: 'metric',
      };

      // Act
      interceptor.onRequest(requestOptions, handler);

      // Assert
      expect(requestOptions.queryParameters, equals(expectedParams));
    });

    test('should override existing app_id and units if present', () {
      // Arrange
      final existingParams = {
        ApiParams.APP_ID: 'old_key',
        ApiParams.UNITS: 'imperial',
        'other': 'param',
      };
      requestOptions.queryParameters = Map.from(existingParams);
      final expectedParams = {
        'other': 'param',
        ApiParams.APP_ID: AppConfig.apiKey,
        ApiParams.UNITS: 'metric',
      };

      // Act
      interceptor.onRequest(requestOptions, handler);

      // Assert
      expect(requestOptions.queryParameters, equals(expectedParams));
    });
  });
} 