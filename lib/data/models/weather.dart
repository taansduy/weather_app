import 'package:weather/core/utils/map_ext.dart';

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather({
    required this.id,
    this.main = '',
    this.description = '',
    this.icon = '',
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json.parseInt('id'),
      main: json.parseString('main'),
      description: json.parseString('description'),
      icon: json.parseString('icon'),
    );
  }
}
