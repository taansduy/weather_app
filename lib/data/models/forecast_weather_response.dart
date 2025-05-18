import 'package:weather/core/utils/map_ext.dart';
import 'package:weather/data/models/clouds.dart';
import 'package:weather/data/models/current_weather.dart';
import 'package:weather/data/models/rain.dart';
import 'package:weather/data/models/sys.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/data/models/wind.dart';

class ForecastWeatherResponse {
  final int cod;
  final String message;
  final int cnt;
  final List<ForecastWeather> list;

  ForecastWeatherResponse(
      {required this.cod,
      required this.message,
      required this.cnt,
      required this.list});

  factory ForecastWeatherResponse.fromJson(Map<String, dynamic> json) {
    return ForecastWeatherResponse(
        cod: json.parseInt('cod'),
        message: json.parseString('message'),
        cnt: json.parseInt('cnt'),
        list: List<ForecastWeather>.from(
            json.parseListMap('list').map((e) => ForecastWeather.fromJson(e))));
  }
}

class ForecastWeather {
  final int dt;
  final Main main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;
  final Rain rain;
  final Sys sys;
  final String dtTxt;

  ForecastWeather(
      {required this.dt,
      required this.main,
      required this.weather,
      required this.clouds,
      required this.wind,
      required this.visibility,
      required this.pop,
      required this.rain,
      required this.sys,
      required this.dtTxt});

  factory ForecastWeather.fromJson(Map<String, dynamic> json) {
    return ForecastWeather(
        dt: json.parseInt('dt'),
        main: Main.fromJson(json.parseMap('main')),
        weather: List<Weather>.from(
            json.parseListMap('weather').map((e) => Weather.fromJson(e))),
        clouds: Clouds.fromJson(json.parseMap('clouds')),
        wind: Wind.fromJson(json.parseMap('wind')),
        visibility: json.parseInt('visibility'),
        pop: json.parseDouble('pop'),
        rain: Rain.fromJson(json.parseMap('rain')),
        sys: Sys.fromJson(json.parseMap('sys')),
        dtTxt: json.parseString('dt_txt'));
  }
}
