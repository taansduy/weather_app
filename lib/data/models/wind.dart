import 'package:weather/core/utils/map_ext.dart';

class Wind {
  final double speed;
  final int deg;
  final double gust;

  Wind({required this.speed, required this.deg, required this.gust});

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(speed: json.parseDouble('speed'), deg: json.parseInt('deg'), gust: json.parseDouble('gust'));
  }
}
