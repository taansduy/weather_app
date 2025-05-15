import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';
import 'package:weather/presentation/controllers/weather/weather_info_bloc.dart';
import 'package:weather/presentation/widgets/weather/weather_error_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_fetching_widget.dart';

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
      backgroundColor: Colors.white,
      body: BlocBuilder<WeatherInfoCubit, WeatherInfoState>(
        builder: (context, state) {
          switch (state) {
            case FetchWeatherInfoSuccess(
                :final currentWeatherInfo,
                :final forecastWeatherInfos
              ):
              return const Center(child: Text("Success"));
            case FetchWeatherInfoFailure(:final error):
              return WeatherErrorWidget(error: error, onRetry: () {
                context.read<WeatherInfoCubit>().fetchWeatherInfo();
              });
            default:
              return Center(child: const WeatherFetchingWidget());
          }
        },
      ),
    );
  }
}
