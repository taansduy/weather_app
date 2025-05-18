import 'package:weather/core/utils/map_ext.dart';

class Sys {
  final int type;
  final int id;
  final String country;
  final int sunrise;
  final int sunset;
  final String pod;

  Sys(
      {required this.type,
      required this.id,
      required this.country,
      required this.sunrise,
      required this.sunset,
      required this.pod});

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
        type: json.parseInt('type'),
        id: json.parseInt('id'),
        country: json.parseString('country'),
        sunrise: json.parseInt('sunrise'),
        sunset: json.parseInt('sunset'),
        pod: json.parseString('pod'));
  }
}
