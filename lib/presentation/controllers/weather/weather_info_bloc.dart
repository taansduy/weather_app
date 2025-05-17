import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/data/models/weather_request.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';

class WeatherInfoState {
  final WeatherRequest? request;

  WeatherInfoState({this.request});

  WeatherInfoState copyWith({
    WeatherRequest? request,
    CurrentWeatherInfo? currentWeatherInfo,
    List<ForecastWeatherInfo>? forecastWeatherInfos,
  }) =>
      WeatherInfoState(
        request: request ?? this.request,
      );

  WeatherInfoState fetching() => FetchingWeatherInfo(request: request);
  WeatherInfoState success({
    required CurrentWeatherInfo currentWeatherInfo,
    required List<ForecastWeatherInfo> forecastWeatherInfos,
  }) =>
      FetchWeatherInfoSuccess(
          request: request,
          currentWeatherInfo: currentWeatherInfo,
          forecastWeatherInfos: forecastWeatherInfos);
  WeatherInfoState failure({required String error}) =>
      FetchWeatherInfoFailure(request: request, error: error);
}

class FetchingWeatherInfo extends WeatherInfoState {
  FetchingWeatherInfo({super.request});
}

class FetchWeatherInfoSuccess extends WeatherInfoState {
  final CurrentWeatherInfo currentWeatherInfo;
  final List<ForecastWeatherInfo> forecastWeatherInfos;

  FetchWeatherInfoSuccess(
      {super.request,
      required this.currentWeatherInfo,
      this.forecastWeatherInfos = const []});

  @override
  FetchWeatherInfoSuccess copyWith({
    WeatherRequest? request,
    CurrentWeatherInfo? currentWeatherInfo,
    List<ForecastWeatherInfo>? forecastWeatherInfos,
  }) =>
      FetchWeatherInfoSuccess(
        request: request ?? super.request,
        currentWeatherInfo: currentWeatherInfo ?? this.currentWeatherInfo,
        forecastWeatherInfos: forecastWeatherInfos ?? this.forecastWeatherInfos,
      );
}

class FetchWeatherInfoFailure extends WeatherInfoState {
  final String error;

  FetchWeatherInfoFailure({super.request, required this.error});
}

class WeatherInfoCubit extends Cubit<WeatherInfoState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  final GetForecastWeatherUseCase _getForecastWeatherUseCase;

  WeatherInfoCubit({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required GetForecastWeatherUseCase getForecastWeatherUseCase,
  })  : _getCurrentWeatherUseCase = getCurrentWeatherUseCase,
        _getForecastWeatherUseCase = getForecastWeatherUseCase,
        super(FetchingWeatherInfo());

  void fetchWeatherInfo() async {
    emit(state.fetching());
    var weatherRequest = state.request;
    if (weatherRequest == null) {
      return;
    }
    var results = await Future.wait([
      _getCurrentWeatherUseCase.call(weatherRequest),
      _getForecastWeatherUseCase.call(weatherRequest)
    ]);

    var currentWeatherInfo = results[0];
    var forecastWeatherInfos = results[1];
    if (currentWeatherInfo is Success<CurrentWeatherInfo>) {
      emit(state.success(
        currentWeatherInfo: currentWeatherInfo.data,
        forecastWeatherInfos:
            forecastWeatherInfos is Success<List<ForecastWeatherInfo>>
                ? forecastWeatherInfos.data
                : [],
      ));
    } else {
      emit(state.failure(error: "Something went wrong at our end!"));
    }
  }

  void updateLocation(double latitude, double longitude) {
    emit(state.copyWith(request: WeatherRequest(lat: latitude, lon: longitude)));
    fetchWeatherInfo();
  }
}
