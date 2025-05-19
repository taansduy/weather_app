import 'package:flutter/material.dart';
import 'package:weather/core/config/app_color.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const WeatherErrorWidget(
      {super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.error,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error, style: Theme.of(context)
              .textTheme
              .displayLarge?.copyWith(color: AppColors.white),),
          SizedBox(height: 44),
          ElevatedButton(
              onPressed: onRetry,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  "RETRY",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.white, fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
}
