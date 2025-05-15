import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/core/constants/images.dart';

class WeatherFetchingWidget extends StatefulWidget {

  const WeatherFetchingWidget({super.key});

  @override
  State<WeatherFetchingWidget> createState() => _WeatherFetchingWidgetState();
}

class _WeatherFetchingWidgetState extends State<WeatherFetchingWidget>  with SingleTickerProviderStateMixin{
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 1500))..repeat();
  }
  @override
  Widget build(BuildContext context) {
    print("build");
    return RotationTransition(
      turns: _animationController,
      child: Image.asset(
         Images.icLoading,
        width: 96,
        height: 96,
      ),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}