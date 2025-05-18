import 'package:weather/core/utils/map_ext.dart';

class Rain {
  final double oneHour;

  Rain({required this.oneHour});

  factory Rain.fromJson(Map<String, dynamic> json) {
    return Rain(oneHour: json.parseDouble('1h'));
  }
}

