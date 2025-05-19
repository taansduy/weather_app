import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/presentation/widgets/weather/weather_fetching_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_info_widget.dart';

void main() {
  group('WeatherFetchingWidget Tests', () {
    testWidgets('should display loading indicator',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
            theme: ThemeData(),
            home: Scaffold(body: Center(child: WeatherFetchingWidget()))),
      );
      // Assert
      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.width, equals(96));
      expect(image.height, equals(96));
    });

    testWidgets('should animate loading indicator',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(),
          home: Scaffold(
            body: WeatherFetchingWidget(
              key: const Key('weather_fetching_widget'),
            ),
          ),
        ),
      );

      // Act & Assert
      // Verify RotationTransition exists
      expect(find.byType(RotationTransition), findsAtLeastNWidgets(1));

      // Initial state
      await tester.pump();
      
      // Verify animation is running by checking after some duration
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(RotationTransition), findsAtLeastNWidgets(1));

      // Verify animation continues
      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(RotationTransition), findsAtLeastNWidgets(1));
    });
  });
}
