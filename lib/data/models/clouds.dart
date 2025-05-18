import 'package:weather/core/utils/map_ext.dart';

class Clouds {
  final int all;

  Clouds({required this.all});

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(all: json.parseInt('all'));
  }
}
