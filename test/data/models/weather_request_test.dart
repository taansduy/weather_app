import 'package:flutter_test/flutter_test.dart';
import 'package:weather/data/models/weather_request.dart';

void main() {
  group('WeatherRequest', () {
    test('should create WeatherRequest with correct values', () {
      // Arrange
      const lat = 10.0;
      const lon = 20.0;

      // Act
      final request = WeatherRequest(lat: lat, lon: lon);

      // Assert
      expect(request.lat, equals(lat));
      expect(request.lon, equals(lon));
    });

    test('should convert to map correctly', () {
      // Arrange
      const lat = 10.0;
      const lon = 20.0;
      final request = WeatherRequest(lat: lat, lon: lon);

      // Act
      final map = request.toMap();

      // Assert
      expect(map, isA<Map<String, dynamic>>());
      expect(map['lat'], equals(lat));
      expect(map['lon'], equals(lon));
    });
  });
} 