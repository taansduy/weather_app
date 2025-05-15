class Parser {
  static String asString(dynamic value, {String defaultValue = ''}) {
    try {
      if (value == null) return defaultValue;
      if (value is String) return value;
      return value.toString();
    } catch (_) {
      return defaultValue;
    }
  }

  static String? asStringOrNull(dynamic value) {
    try {
      if (value == null) return null;
      if (value is String) return value;
      return value.toString();
    } catch (_) {
      return null;
    }
  }

  static int asInt(dynamic value, {int defaultValue = 0}) {
    try {
      if (value == null) return defaultValue;
      if (value is int) return value;
      return int.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }

  static int? asIntOrNull(dynamic value) {
    try {
      if (value == null) return null;
      if (value is int) return value;
      return int.tryParse(value.toString());
    } catch (_) {
      return null;
    }
  }

  static double asDouble(dynamic value, {double defaultValue = 0.0}) {
    try {
      if (value == null) return defaultValue;
      if (value is num) return value.toDouble();
      return double.parse(value.toString());
    } catch (_) {
      return defaultValue;
    }
  }

  static double? asDoubleOrNull(dynamic value) {
    try {
      if (value == null) return null;
      if (value is num) return value.toDouble();
      return double.tryParse(value.toString());
    } catch (_) {
      return null;
    }
  }

  static DateTime asDateTime(dynamic value, {DateTime? defaultValue}) {
    try {
      if (value == null) return defaultValue ?? DateTime.now();
      final dateStr = value.toString();
      if (dateStr.isEmpty) return defaultValue ?? DateTime.now();
      return DateTime.parse(dateStr);
    } catch (_) {
      return defaultValue ?? DateTime.now();
    }
  }

  static DateTime? asDateTimeOrNull(dynamic value) {
    try {
      if (value == null) return null;
      final dateStr = value.toString();
      if (dateStr.isEmpty) return null;
      return DateTime.parse(dateStr);
    } catch (_) {
      return null;
    }
  }

  static Map<String, dynamic> asMap(
      dynamic value, {
        Map<String, dynamic> defaultValue = const {},
      }) {
    try {
      if (value is Map<String, dynamic>) return Map.from(value);
      if (value is Map<dynamic, dynamic>) {
        return {for (final k in value.keys) k.toString(): value[k]};
      }
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static Map<String, dynamic>? asMapOrNull(dynamic value) {
    try {
      if (value is Map<String, dynamic>) return Map.from(value);
      if (value is Map<dynamic, dynamic>) {
        return {for (final k in value.keys) k.toString(): value[k]};
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static List<Map<String, dynamic>> asListMap(
      dynamic value, {
        List<Map<String, dynamic>> defaultValue = const [],
      }) {
    try {
      if (value is List<dynamic>) {
        return value
            .map((e) => asMap(e, defaultValue: {}))
            .toList()
            .cast<Map<String, dynamic>>();
      }
      return defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  static List<Map<String, dynamic>>? asListMapOrNull(dynamic value) {
    try {
      if (value is List<dynamic>) {
        return value
            .map((e) => asMap(e, defaultValue: {}))
            .toList()
            .cast<Map<String, dynamic>>();
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static List<T>? asListOrNull<T>(
      dynamic value, {
        T Function(dynamic)? converter,
      }) {
    try {
      if (value is List<T>) {
        return List<T>.from(value);
      }
      if (value is List<dynamic>) {
        try {
          final result = List<T>.from(value);
          return result;
        } catch (_) {}

        if (converter != null) {
          return value.map(
                (e) {
              if (e is T) {
                return e;
              }

              return converter(e);
            },
          ).toList();
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static bool asBool(dynamic value, {bool defaultValue = false}) {
    return asBoolOrNull(value) ?? defaultValue;
  }

  static bool? asBoolOrNull(dynamic value) {
    try {
      if (value is bool) {
        return value;
      }
      if (value is String) {
        if (value == 'true') {
          return true;
        } else if (value == 'false') {
          return false;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static DateTime? asSecondToDate(dynamic value,
      {bool isUtc = false, DateTime? defaultValue}) {
    try {
      var valueInt = asIntOrNull(value);
      if (valueInt == null) {
        return defaultValue;
      }
      return DateTime.fromMillisecondsSinceEpoch(valueInt * 1000, isUtc: isUtc);
    } catch (e) {
      return defaultValue;
    }
  }

  static DateTime? asDateISO8601(dynamic value, {DateTime? defaultValue}) {
    // parse kiểu string 2020-02-17T20:44:34.000Z sang date
    try {
      if (value == null) return defaultValue;
      final valueStr = value.toString();
      if (valueStr.isEmpty) {
        return defaultValue;
      }
      return DateTime.parse(valueStr);
    } catch (e) {
      return defaultValue;
    }
  }


  static List<String> asListString(
      dynamic value, {
        List<String> defaultValue = const [],
      }) {
    return asList<String>(
      value,
      defaultValue: defaultValue,
      converter: (value) => value.toString(),
    );
  }

  static List<String>? asListStringOrNull(dynamic value) {
    return asListOrNull<String>(
      value,
      converter: (value) => value.toString(),
    );
  }

  static List<T> asList<T>(
      dynamic value, {
        List<T> defaultValue = const [],
        T Function(dynamic)? converter,
      }) {
    return asListOrNull<T>(value, converter: converter) ?? defaultValue;
  }





}