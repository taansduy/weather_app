import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/presentation/widgets/weather/weather_info_widget.dart';

void main() {
  group('WeatherInfoWidget Tests', () {
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

    testWidgets('should display current weather information correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: WeatherInfoWidget(
              currentWeatherInfo: testCurrentWeather,
              forecastWeatherInfos: testForecastWeather,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(); // Wait for animations

      // Assert
      expect(find.text('20°'), findsOneWidget);
      expect(find.text('London'), findsOneWidget);
    });

    testWidgets('should display forecast list correctly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: WeatherInfoWidget(
              currentWeatherInfo: testCurrentWeather,
              forecastWeatherInfos: testForecastWeather,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(); // Wait for animations

      // Assert
      expect(find.text('21 C'), findsOneWidget);
      expect(find.text('19 C'), findsOneWidget);
    });

    testWidgets('should handle empty forecast list', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: WeatherInfoWidget(
              currentWeatherInfo: testCurrentWeather,
              forecastWeatherInfos: [],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle(); // Wait for animations

      // Assert
      expect(find.text('20°'), findsOneWidget);
      expect(find.text('London'), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('should animate content on initial build',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: WeatherInfoWidget(
              currentWeatherInfo: testCurrentWeather,
              forecastWeatherInfos: testForecastWeather,
            ),
          ),
        ),
      );

      // Assert - Check initial position (slide from bottom)
      final initialSlideTransition =
          tester.widget<SlideTransition>(find.byType(SlideTransition));
      expect(
        initialSlideTransition.position.value.dy,
        equals(1.0),
      );

      // Act - Wait for animation
      await tester.pumpAndSettle();

      // Assert - Check final position
      final finalSlideTransition =
          tester.widget<SlideTransition>(find.byType(SlideTransition));
      expect(
        finalSlideTransition.position.value.dy,
        equals(0.0),
      );
    });
  });
} 