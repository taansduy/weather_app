import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';

class ForecastWeatherItemWidget extends StatelessWidget {
  final ForecastWeatherInfo forecastWeatherInfo;
  const ForecastWeatherItemWidget(
      {super.key, required this.forecastWeatherInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 80,
      child: Row(
        children: [
          Expanded(
              child: Text(DateFormat("EEEE").format(forecastWeatherInfo.date), style: Theme.of(context).textTheme.bodyMedium,)),
          Text("${forecastWeatherInfo.celciusTemp.ceil()} C", style: Theme.of(context).textTheme.bodyMedium,),
        ],
      ),
    );
  }
}
