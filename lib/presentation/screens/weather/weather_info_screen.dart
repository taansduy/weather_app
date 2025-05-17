import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';
import 'package:weather/presentation/controllers/weather/weather_info_bloc.dart';
import 'package:weather/presentation/widgets/geo/geo_provider_wrapper.dart';
import 'package:weather/presentation/widgets/weather/weather_error_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_fetching_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_info_widget.dart';

class WeatherInfoScreen extends StatefulWidget {
  const WeatherInfoScreen._({super.key});

  static Widget newInstance({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required GetForecastWeatherUseCase getForecastWeatherUseCase,
  }) {
    return BlocProvider(
      create: (context) => WeatherInfoCubit(
        getCurrentWeatherUseCase: getCurrentWeatherUseCase,
        getForecastWeatherUseCase: getForecastWeatherUseCase,
      ),
      child: const WeatherInfoScreen._(),
    );
  }

  @override
  State<WeatherInfoScreen> createState() => _WeatherInfoScreenState();
}

class _WeatherInfoScreenState extends State<WeatherInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeoProviderWrapper(
        onLocationReady: (Position position) {
          context.read<WeatherInfoCubit>().updateLocation(position.latitude, position.longitude);
        },
        child: BlocBuilder<WeatherInfoCubit, WeatherInfoState>(
          builder: (context, state) {
            switch (state) {
              case FetchWeatherInfoSuccess(
                  :final currentWeatherInfo,
                  :final forecastWeatherInfos
                ):
                return WeatherInfoWidget(currentWeatherInfo: currentWeatherInfo, forecastWeatherInfos: forecastWeatherInfos);
              case FetchWeatherInfoFailure(:final error):
                return WeatherErrorWidget(error: error, onRetry: () {
                  context.read<WeatherInfoCubit>().fetchWeatherInfo();
                });
              default:
                return Center(child: const WeatherFetchingWidget());
            }
          },
        ),
      ),
    );
  }
}
