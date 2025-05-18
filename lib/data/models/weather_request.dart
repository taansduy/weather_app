class WeatherRequest {
  final double lat;
  final double lon;

  WeatherRequest({required this.lat, required this.lon});

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }
}

