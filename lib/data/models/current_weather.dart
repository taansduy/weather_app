import 'package:weather/core/utils/map_ext.dart';
import 'package:weather/data/models/clouds.dart';
import 'package:weather/data/models/rain.dart';
import 'package:weather/data/models/sys.dart';
import 'package:weather/data/models/weather.dart';
import 'package:weather/data/models/wind.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';

class Coord {
  final double lat;
  final double lon;

  Coord({required this.lat, required this.lon});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(lat: json.parseDouble('lat'), lon: json.parseDouble('lon'));
  }
}

class Main {
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double seaLevel;
  final double grndLevel;

  Main(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel});

  factory Main.fromJson(Map<String, dynamic> json) {
    return Main(
        temp: json.parseDouble('temp'),
        feelsLike: json.parseDouble('feels_like'),
        tempMin: json.parseDouble('temp_min'),
        tempMax: json.parseDouble('temp_max'),
        pressure: json.parseInt('pressure'),
        humidity: json.parseInt('humidity'),
        seaLevel: json.parseDouble('sea_level'),
        grndLevel: json.parseDouble('grnd_level'));
  }
}

class CurrentWeatherResposne {
  final int dt;
  final Coord coord;
  final String base;
  final Main main;
  final int visibility;
  final Wind wind;
  final Rain rain;
  final Clouds clouds;
  final Sys sys;
  final String name;
  final int timezone;
  final List<Weather> weather;
  final int cod;

  CurrentWeatherResposne(
      {required this.dt,
      required this.coord,
      required this.base,
      required this.main,
      required this.visibility,
      required this.wind,
      required this.rain,
      required this.clouds,
      required this.sys,
      required this.name,
      required this.timezone,
      required this.cod,
      required this.weather});

  factory CurrentWeatherResposne.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherResposne(
      dt: json.parseInt('dt'),
      coord: Coord.fromJson(json.parseMap('coord')),
      base: json.parseString('base'),
      main: Main.fromJson(json.parseMap('main')),
      visibility: json.parseInt('visibility'),
      wind: Wind.fromJson(json.parseMap('wind')),
      rain: Rain.fromJson(json.parseMap('rain')),
      clouds: Clouds.fromJson(json.parseMap('clouds')),
      sys: Sys.fromJson(json.parseMap('sys')),
      name: json.parseString('name'),
      timezone: json.parseInt('timezone'),
      weather: List<Weather>.from(
          json.parseListMap('weather').map((e) => Weather.fromJson(e))),
      cod: json.parseInt('cod'),
    );
  }
}

extension CurrentWeatherEx on CurrentWeatherResposne {
  CurrentWeatherInfo toCurrentWeatherInfo() {
    return CurrentWeatherInfo(cityName: name, celciusTemp: main.temp);
  }
}
