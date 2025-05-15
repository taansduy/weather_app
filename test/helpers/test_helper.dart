import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/network/weather_app_dio_client.dart';

class MockWeatherAppDioClient extends Mock implements WeatherAppDioClient {}

class TestHelper {
  static MockWeatherAppDioClient getMockDioClient() {
    return MockWeatherAppDioClient();
  }

  static Future<void> pumpWidget(WidgetTester tester, Widget widget) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
  }
} 