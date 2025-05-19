import 'package:flutter_test/flutter_test.dart';
import 'package:weather/core/utils/parser.dart';

void main() {
  group('Parser', () {
    group('asString', () {
      test('should return string value', () {
        expect(Parser.asString('test'), equals('test'));
        expect(Parser.asString(123), equals('123'));
      });

      test('should return default value for null', () {
        expect(Parser.asString(null), equals(''));
        expect(Parser.asString(null, defaultValue: 'default'), equals('default'));
      });
    });

    group('asStringOrNull', () {
      test('should return string value', () {
        expect(Parser.asStringOrNull('test'), equals('test'));
        expect(Parser.asStringOrNull(123), equals('123'));
      });

      test('should return null for null', () {
        expect(Parser.asStringOrNull(null), isNull);
      });
    });

    group('asInt', () {
      test('should return int value', () {
        expect(Parser.asInt(123), equals(123));
        expect(Parser.asInt('123'), equals(123));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asInt('abc'), equals(0));
        expect(Parser.asInt('abc', defaultValue: -1), equals(-1));
      });

      test('should return default value for null', () {
        expect(Parser.asInt(null), equals(0));
        expect(Parser.asInt(null, defaultValue: -1), equals(-1));
      });
    });

    group('asIntOrNull', () {
      test('should return int value', () {
        expect(Parser.asIntOrNull(123), equals(123));
        expect(Parser.asIntOrNull('123'), equals(123));
      });

      test('should return null for invalid input', () {
        expect(Parser.asIntOrNull('abc'), isNull);
      });

      test('should return null for null', () {
        expect(Parser.asIntOrNull(null), isNull);
      });
    });

    group('asDouble', () {
      test('should return double value', () {
        expect(Parser.asDouble(123.45), equals(123.45));
        expect(Parser.asDouble('123.45'), equals(123.45));
        expect(Parser.asDouble(123), equals(123.0));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asDouble('abc'), equals(0.0));
        expect(Parser.asDouble('abc', defaultValue: -1.0), equals(-1.0));
      });

      test('should return default value for null', () {
        expect(Parser.asDouble(null), equals(0.0));
        expect(Parser.asDouble(null, defaultValue: -1.0), equals(-1.0));
      });
    });

    group('asDoubleOrNull', () {
      test('should return double value', () {
        expect(Parser.asDoubleOrNull(123.45), equals(123.45));
        expect(Parser.asDoubleOrNull('123.45'), equals(123.45));
        expect(Parser.asDoubleOrNull(123), equals(123.0));
      });

      test('should return null for invalid input', () {
        expect(Parser.asDoubleOrNull('abc'), isNull);
      });

      test('should return null for null', () {
        expect(Parser.asDoubleOrNull(null), isNull);
      });
    });

    group('asDateTime', () {
      test('should return DateTime value', () {
        final date = DateTime(2024, 3, 20);
        expect(Parser.asDateTime(date.toIso8601String()), equals(date));
      });

      test('should return default value for invalid input', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asDateTime('invalid', defaultValue: defaultDate), equals(defaultDate));
      });

      test('should return default value for null', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asDateTime(null, defaultValue: defaultDate), equals(defaultDate));
      });
    });

    group('asDateTimeOrNull', () {
      test('should return DateTime value', () {
        final date = DateTime(2024, 3, 20);
        expect(Parser.asDateTimeOrNull(date.toIso8601String()), equals(date));
      });

      test('should return null for invalid input', () {
        expect(Parser.asDateTimeOrNull('invalid'), isNull);
      });

      test('should return null for null', () {
        expect(Parser.asDateTimeOrNull(null), isNull);
      });
    });

    group('asMap', () {
      test('should return Map value', () {
        final map = {'key': 'value'};
        expect(Parser.asMap(map), equals(map));
      });

      test('should convert dynamic map to string map', () {
        final dynamicMap = {1: 'value'};
        expect(Parser.asMap(dynamicMap), equals({'1': 'value'}));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asMap('invalid'), equals({}));
        expect(Parser.asMap('invalid', defaultValue: {'default': 'value'}), equals({'default': 'value'}));
      });
    });

    group('asMapOrNull', () {
      test('should return Map value', () {
        final map = {'key': 'value'};
        expect(Parser.asMapOrNull(map), equals(map));
      });

      test('should convert dynamic map to string map', () {
        final dynamicMap = {1: 'value'};
        expect(Parser.asMapOrNull(dynamicMap), equals({'1': 'value'}));
      });

      test('should return null for invalid input', () {
        expect(Parser.asMapOrNull('invalid'), isNull);
      });
    });

    group('asListMap', () {
      test('should return List<Map> value', () {
        final list = [{'key': 'value1'}, {'key': 'value2'}];
        expect(Parser.asListMap(list), equals(list));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asListMap('invalid'), equals([]));
        expect(Parser.asListMap('invalid', defaultValue: [{'default': 'value'}]), equals([{'default': 'value'}]));
      });
    });

    group('asListMapOrNull', () {
      test('should return List<Map> value', () {
        final list = [{'key': 'value1'}, {'key': 'value2'}];
        expect(Parser.asListMapOrNull(list), equals(list));
      });

      test('should return null for invalid input', () {
        expect(Parser.asListMapOrNull('invalid'), isNull);
      });
    });

    group('asBool', () {
      test('should return bool value', () {
        expect(Parser.asBool(true), isTrue);
        expect(Parser.asBool('true'), isTrue);
        expect(Parser.asBool(false), isFalse);
        expect(Parser.asBool('false'), isFalse);
      });

      test('should return default value for invalid input', () {
        expect(Parser.asBool('invalid'), isFalse);
        expect(Parser.asBool('invalid', defaultValue: true), isTrue);
      });

      test('should return default value for null', () {
        expect(Parser.asBool(null), isFalse);
        expect(Parser.asBool(null, defaultValue: true), isTrue);
      });
    });

    group('asBoolOrNull', () {
      test('should return bool value', () {
        expect(Parser.asBoolOrNull(true), isTrue);
        expect(Parser.asBoolOrNull('true'), isTrue);
        expect(Parser.asBoolOrNull(false), isFalse);
        expect(Parser.asBoolOrNull('false'), isFalse);
      });

      test('should return null for invalid input', () {
        expect(Parser.asBoolOrNull('invalid'), isNull);
      });

      test('should return null for null', () {
        expect(Parser.asBoolOrNull(null), isNull);
      });
    });

    group('asSecondToDate', () {
      test('should return DateTime from seconds', () {
        final timestamp = 1710939045; // 2024-03-20 15:30:45
        final result = Parser.asSecondToDate(timestamp);
        expect(result?.year, equals(2024));
        expect(result?.month, equals(3));
        expect(result?.day, equals(20));
      });

      test('should return default value for invalid input', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asSecondToDate('invalid', defaultValue: defaultDate), equals(defaultDate));
      });

      test('should return default value for null', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asSecondToDate(null, defaultValue: defaultDate), equals(defaultDate));
      });
    });

    group('asDateISO8601', () {
      test('should return DateTime from ISO8601 string', () {
        final dateStr = '2024-03-20T15:30:45.000Z';
        final result = Parser.asDateISO8601(dateStr);
        expect(result?.year, equals(2024));
        expect(result?.month, equals(3));
        expect(result?.day, equals(20));
        expect(result?.hour, equals(15));
        expect(result?.minute, equals(30));
        expect(result?.second, equals(45));
      });

      test('should return default value for invalid input', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asDateISO8601('invalid', defaultValue: defaultDate), equals(defaultDate));
      });

      test('should return default value for null', () {
        final defaultDate = DateTime(2024, 1, 1);
        expect(Parser.asDateISO8601(null, defaultValue: defaultDate), equals(defaultDate));
      });
    });

    group('asListString', () {
      test('should return List<String> value', () {
        final list = ['a', 'b', 'c'];
        expect(Parser.asListString(list), equals(list));
      });

      test('should convert mixed list to string list', () {
        final mixedList = [1, 'b', 3.0];
        expect(Parser.asListString(mixedList), equals(['1', 'b', '3.0']));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asListString('invalid'), equals([]));
        expect(Parser.asListString('invalid', defaultValue: ['default']), equals(['default']));
      });
    });

    group('asListStringOrNull', () {
      test('should return List<String> value', () {
        final list = ['a', 'b', 'c'];
        expect(Parser.asListStringOrNull(list), equals(list));
      });

      test('should convert mixed list to string list', () {
        final mixedList = [1, 'b', 3.0];
        expect(Parser.asListStringOrNull(mixedList), equals(['1', 'b', '3.0']));
      });

      test('should return null for invalid input', () {
        expect(Parser.asListStringOrNull('invalid'), isNull);
      });
    });

    group('asList', () {
      test('should return List<T> value', () {
        final list = [1, 2, 3];
        expect(Parser.asList<int>(list), equals(list));
      });

      test('should convert list with converter', () {
        final list = ['1', '2', '3'];
        expect(Parser.asList<int>(list, converter: (e) => int.parse(e)), equals([1, 2, 3]));
      });

      test('should return default value for invalid input', () {
        expect(Parser.asList<int>('invalid'), equals([]));
        expect(Parser.asList<int>('invalid', defaultValue: [1, 2, 3]), equals([1, 2, 3]));
      });
    });
  });
} 