import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/core/config/app_color.dart';
import 'package:weather/core/constants/images.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/presentation/widgets/weather/forecast_weather_item_widget.dart';

class WeatherInfoWidget extends StatefulWidget {
  final CurrentWeatherInfo currentWeatherInfo;
  final List<ForecastWeatherInfo> forecastWeatherInfos;

  const WeatherInfoWidget(
      {super.key,
      required this.currentWeatherInfo,
      required this.forecastWeatherInfos});

  @override
  State<WeatherInfoWidget> createState() => _WeatherInfoWidgetState();
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween<Offset>(
      begin: Offset(0, 1), // Start from bottom (off-screen)
      end: Offset.zero,   // Slide to original position
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 56),
          Container(child: Text("${widget.currentWeatherInfo.celciusTemp.ceil()}°", style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,)), 
          SizedBox(height: 24),
          Text(widget.currentWeatherInfo.cityName, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: AppColors.secondarySurface),textAlign: TextAlign.center,),
          SizedBox(height: 62),
          Expanded(
              child: SlideTransition(
                position: _animation,
                child: Container(
                  color: Colors.white,
                  child: ListView.separated(
                      padding: EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return ForecastWeatherItemWidget(
                            forecastWeatherInfo:
                                widget.forecastWeatherInfos[index]);
                      },
                      itemCount: widget.forecastWeatherInfos.length,
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Theme.of(context).colorScheme.surfaceBright, 
                          height: 1,
                        );
                      }),
                ),
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
