import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/rain.dart';

void main() {
  group('Rain', () {
    test('should create Rain with correct value', () {
      // Arrange
      const oneHour = 0.5;

      // Act
      final rain = Rain(oneHour: oneHour);

      // Assert
      expect(rain.oneHour, equals(oneHour));
    });

    test('should create Rain from JSON', () {
      // Arrange
      final json = {'1h': 0.5};

      // Act
      final rain = Rain.fromJson(json);

      // Assert
      expect(rain.oneHour, equals(0.5));
    });

    test('should handle string value in JSON', () {
      // Arrange
      final json = {'1h': '0.5'};

      // Act
      final rain = Rain.fromJson(json);

      // Assert
      expect(rain.oneHour, equals(0.5));
    });

    test('should handle zero value in JSON', () {
      // Arrange
      final json = {'1h': 0.0};

      // Act
      final rain = Rain.fromJson(json);

      // Assert
      expect(rain.oneHour, equals(0.0));
    });
  });
} 