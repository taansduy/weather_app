import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/clouds.dart';

void main() {
  group('Clouds', () {
    test('should create Clouds with correct value', () {
      // Arrange
      const all = 20;

      // Act
      final clouds = Clouds(all: all);

      // Assert
      expect(clouds.all, equals(all));
    });

    test('should create Clouds from JSON', () {
      // Arrange
      final json = {'all': 20};

      // Act
      final clouds = Clouds.fromJson(json);

      // Assert
      expect(clouds.all, equals(20));
    });

    test('should handle string value in JSON', () {
      // Arrange
      final json = {'all': '20'};

      // Act
      final clouds = Clouds.fromJson(json);

      // Assert
      expect(clouds.all, equals(20));
    });
  });
} 