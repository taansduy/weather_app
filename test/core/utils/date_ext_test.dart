import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/utils/date_ext.dart';

void main() {
  group('DateExt', () {
    group('removeTime', () {
      test('should remove time part from DateTime', () {
        // Arrange
        final dateTime = DateTime(2024, 3, 20, 15, 30, 45);

        // Act
        final result = dateTime.removeTime();

        // Assert
        expect(result.year, equals(2024));
        expect(result.month, equals(3));
        expect(result.day, equals(20));
        expect(result.hour, equals(0));
        expect(result.minute, equals(0));
        expect(result.second, equals(0));
        expect(result.millisecond, equals(0));
      });
    });

    group('isTheSameDate', () {
      test('should return true for same date with different times', () {
        // Arrange
        final date1 = DateTime(2024, 3, 20, 15, 30, 45);
        final date2 = DateTime(2024, 3, 20, 10, 20, 30);

        // Act
        final result = date1.isTheSameDate(date2);

        // Assert
        expect(result, isTrue);
      });

      test('should return false for different dates', () {
        // Arrange
        final date1 = DateTime(2024, 3, 20);
        final date2 = DateTime(2024, 3, 21);

        // Act
        final result = date1.isTheSameDate(date2);

        // Assert
        expect(result, isFalse);
      });

      test('should return false for different months', () {
        // Arrange
        final date1 = DateTime(2024, 3, 20);
        final date2 = DateTime(2024, 4, 20);

        // Act
        final result = date1.isTheSameDate(date2);

        // Assert
        expect(result, isFalse);
      });

      test('should return false for different years', () {
        // Arrange
        final date1 = DateTime(2024, 3, 20);
        final date2 = DateTime(2025, 3, 20);

        // Act
        final result = date1.isTheSameDate(date2);

        // Assert
        expect(result, isFalse);
      });
    });
  });
} 