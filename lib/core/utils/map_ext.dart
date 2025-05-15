import 'package:weather/core/utils/parser.dart';

extension MapParser on Map<dynamic, dynamic> {
  double parseDouble(String key, {double defaultValue = 0.0}) {
    return Parser.asDouble(this[key], defaultValue: defaultValue);
  }

  double? parseDoubleOrNull(String key) {
    return Parser.asDoubleOrNull(this[key]);
  }

  String parseString(String key, {String defaultValue = ""}) {
    return Parser.asString(this[key], defaultValue: defaultValue);
  }

  String? parseStringOrNull(String key) {
    return Parser.asStringOrNull(this[key]);
  }

  DateTime? parseSecondToDate(String key, {bool isUtc = false}) {
    return Parser.asSecondToDate(this[key], isUtc: isUtc);
  }

  bool parseBool(String key, {bool defaultValue = false}) {
    return Parser.asBool(this[key], defaultValue: defaultValue);
  }

  bool? parseBoolOrNull(String key) {
    return Parser.asBoolOrNull(this[key]);
  }

  DateTime? parseDateISO8601(String key) {
    return Parser.asDateISO8601(this[key]);
  }

  int parseInt(String key, {int defaultValue = 0}) {
    return Parser.asInt(this[key], defaultValue: defaultValue);
  }

  int? parseIntOrNull(String key) {
    return Parser.asIntOrNull(this[key]);
  }

  Map<String, dynamic> parseMap(String key,
      {Map<String, dynamic>? defaultValue}) {
    return Parser.asMap(this[key], defaultValue: defaultValue ?? <String, dynamic>{});
  }

  Map<String, dynamic>? parseMapOrNull(String key) {
    return Parser.asMapOrNull(this[key]);
  }

  List<Map<String, dynamic>> parseListMap(String key,
      {List<Map<String, dynamic>>? defaultValue}) {
    return Parser.asListMap(this[key], defaultValue: defaultValue ?? <Map<String, dynamic>>[]);
  }

  List<Map<String, dynamic>>? parseListMapOrNull(String key) {
    return Parser.asListMapOrNull(this[key]);
  }

  List<String> parseListString(String key,
      {List<String>? defaultValue }) {
    return Parser.asListString(this[key], defaultValue: defaultValue ?? <String>[]);
  }

  List<String>? parseListStringOrNull(String key) {
    return Parser.asListStringOrNull(this[key]);
  }

  List<T> parseList<T>(
      String key, {
        List<T>? defaultValue ,
        T Function(dynamic)? converter,
      }) {
    return Parser.asList<T>(
      this[key],
      defaultValue: defaultValue ?? <T>[],
      converter: converter,
    );
  }

  List<T>? parseListOrNull<T>(
      String key, {
        T Function(dynamic)? converter,
      }) {
    return Parser.asListOrNull<T>(this[key], converter: converter);
  }

}
