import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/sys.dart';

void main() {
  group('Sys', () {
    test('should create Sys with correct values', () {
      // Arrange
      const type = 1;
      const id = 1;
      const country = 'VN';
      const sunrise = 1234567890;
      const sunset = 1234567890;
      const pod = 'd';

      // Act
      final sys = Sys(
        type: type,
        id: id,
        country: country,
        sunrise: sunrise,
        sunset: sunset,
        pod: pod,
      );

      // Assert
      expect(sys.type, equals(type));
      expect(sys.id, equals(id));
      expect(sys.country, equals(country));
      expect(sys.sunrise, equals(sunrise));
      expect(sys.sunset, equals(sunset));
      expect(sys.pod, equals(pod));
    });

    test('should create Sys from JSON', () {
      // Arrange
      final json = {
        'type': 1,
        'id': 1,
        'country': 'VN',
        'sunrise': 1234567890,
        'sunset': 1234567890,
        'pod': 'd',
      };

      // Act
      final sys = Sys.fromJson(json);

      // Assert
      expect(sys.type, equals(1));
      expect(sys.id, equals(1));
      expect(sys.country, equals('VN'));
      expect(sys.sunrise, equals(1234567890));
      expect(sys.sunset, equals(1234567890));
      expect(sys.pod, equals('d'));
    });

    test('should handle string values in JSON', () {
      // Arrange
      final json = {
        'type': '1',
        'id': '1',
        'country': 'VN',
        'sunrise': '1234567890',
        'sunset': '1234567890',
        'pod': 'd',
      };

      // Act
      final sys = Sys.fromJson(json);

      // Assert
      expect(sys.type, equals(1));
      expect(sys.id, equals(1));
      expect(sys.country, equals('VN'));
      expect(sys.sunrise, equals(1234567890));
      expect(sys.sunset, equals(1234567890));
      expect(sys.pod, equals('d'));
    });
  });
} 