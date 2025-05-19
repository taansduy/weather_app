import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/wind.dart';

void main() {
  group('Wind', () {
    test('should create Wind with correct values', () {
      // Arrange
      const speed = 5.0;
      const deg = 180;
      const gust = 7.0;

      // Act
      final wind = Wind(speed: speed, deg: deg, gust: gust);

      // Assert
      expect(wind.speed, equals(speed));
      expect(wind.deg, equals(deg));
      expect(wind.gust, equals(gust));
    });

    test('should create Wind from JSON', () {
      // Arrange
      final json = {
        'speed': 5.0,
        'deg': 180,
        'gust': 7.0,
      };

      // Act
      final wind = Wind.fromJson(json);

      // Assert
      expect(wind.speed, equals(5.0));
      expect(wind.deg, equals(180));
      expect(wind.gust, equals(7.0));
    });

    test('should handle string values in JSON', () {
      // Arrange
      final json = {
        'speed': '5.0',
        'deg': '180',
        'gust': '7.0',
      };

      // Act
      final wind = Wind.fromJson(json);

      // Assert
      expect(wind.speed, equals(5.0));
      expect(wind.deg, equals(180));
      expect(wind.gust, equals(7.0));
    });
  });
} 