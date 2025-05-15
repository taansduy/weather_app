class ApiPath {
  static String get currentWeatherData => "/weather";
  static String get forecastWeather => "/forecast";
}

class ApiParams {
  static const APP_ID = "appid";
  static const UNITS = "units";
}

class ResponseCode {
  static const success = 200;
}