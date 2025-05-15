import 'package:flutter/material.dart';

class WeatherErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;
  const WeatherErrorWidget({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      width: double.infinity, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          SizedBox(height: 44),
          ElevatedButton(onPressed: onRetry, child: Text("Retry")),
        ],
      ),
    );
  }
}