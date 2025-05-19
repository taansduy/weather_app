import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather/presentation/widgets/weather/weather_error_widget.dart';

void main() {
  group('WeatherErrorWidget Tests', () {
    const testError = 'Test error message';

    testWidgets('should display error message', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherErrorWidget(
              error: testError,
              onRetry: () {},
            ),
          ),
        ),
      );

      // Assert
      expect(find.text(testError), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('should handle retry tap', (WidgetTester tester) async {
      // Arrange
      bool retryTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherErrorWidget(
              error: testError,
              onRetry: () => retryTapped = true,
            ),
          ),
        ),
      );

      // Act
      await tester.tap(find.text('Retry'));
      await tester.pump();

      // Assert
      expect(retryTapped, isTrue);
    });

    testWidgets('should have correct styling', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherErrorWidget(
              error: testError,
              onRetry: () {},
            ),
          ),
        ),
      );

      // Assert
      final container = tester.widget<Container>(find.byType(Container));
      expect(container.color, equals(Colors.red));

      final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox));
      expect(sizedBox.height, equals(44));
    });
  });
} 