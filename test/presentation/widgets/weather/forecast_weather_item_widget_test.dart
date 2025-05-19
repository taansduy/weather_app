import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/presentation/widgets/weather/forecast_weather_item_widget.dart';

void main() {
  group('ForecastWeatherItemWidget Tests', () {
    final testDate = DateTime(2024, 3, 20); // Wednesday, March 20, 2024
    final testForecastInfo = ForecastWeatherInfo(
      celciusTemp: 21.5,
      date: testDate,
    );

    testWidgets('should display forecast information correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: ForecastWeatherItemWidget(
              forecastWeatherInfo: testForecastInfo,
            ),
          ),
        ),
      );

      // Assert
      expect(find.text('22 C'), findsOneWidget); // Tests ceil() of 21.5
      expect(find.text('Wednesday'), findsOneWidget);
    });

    testWidgets('should have correct layout structure',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: ForecastWeatherItemWidget(
              forecastWeatherInfo: testForecastInfo,
            ),
          ),
        ),
      );

      // Assert
      expect(find.byType(Container), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Expanded), findsOneWidget);

      final container = tester.widget<Container>(find.byType(Container));
      expect(container.constraints?.maxHeight, equals(80));
    });

    testWidgets('should use correct text styles', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: ForecastWeatherItemWidget(
              forecastWeatherInfo: testForecastInfo,
            ),
          ),
        ),
      );

      // Assert
      final texts = tester.widgetList<Text>(find.byType(Text));
      for (final text in texts) {
        expect(text.style?.fontSize, equals(Theme.of(tester.element(find.byType(ForecastWeatherItemWidget))).textTheme.bodyMedium?.fontSize));
      }
    });
  });
} 