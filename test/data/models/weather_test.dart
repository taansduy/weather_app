import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/weather.dart';

void main() {
  group('Weather', () {
    test('should create Weather with default values', () {
      // Arrange & Act
      final weather = Weather(id: 800);

      // Assert
      expect(weather.id, equals(800));
      expect(weather.main, equals(''));
      expect(weather.description, equals(''));
      expect(weather.icon, equals(''));
    });

    test('should create Weather with provided values', () {
      // Arrange
      const id = 800;
      const main = 'Clear';
      const description = 'clear sky';
      const icon = '01d';

      // Act
      final weather = Weather(
        id: id,
        main: main,
        description: description,
        icon: icon,
      );

      // Assert
      expect(weather.id, equals(id));
      expect(weather.main, equals(main));
      expect(weather.description, equals(description));
      expect(weather.icon, equals(icon));
    });

    test('should create Weather from JSON', () {
      // Arrange
      final json = {
        'id': 800,
        'main': 'Clear',
        'description': 'clear sky',
        'icon': '01d',
      };

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.id, equals(800));
      expect(weather.main, equals('Clear'));
      expect(weather.description, equals('clear sky'));
      expect(weather.icon, equals('01d'));
    });

    test('should handle missing JSON values', () {
      // Arrange
      final json = {'id': 800};

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.id, equals(800));
      expect(weather.main, equals(''));
      expect(weather.description, equals(''));
      expect(weather.icon, equals(''));
    });
  });
} 