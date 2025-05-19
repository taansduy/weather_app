import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/app/di/app_di.dart';
import 'package:weather/core/config/app_config.dart';
import 'package:weather/core/config/theme.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/core/network/weather_app_dio_client.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/repositories/weather_repository.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';
import 'package:weather/presentation/screens/weather/weather_info_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env
  await dotenv.load(fileName: ".env");
  AppConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<BaseDioClient>(create: (_) => WeatherAppDioClient()),
        ...dataSourcesProviders,
        ...repositoriesProviders,
      ],
      builder: (bc, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: themeData,
          home: WeatherInfoScreen.newInstance(
            getCurrentWeatherUseCase:
                GetCurrentWeatherUseCase(weatherRepository: bc.read()),
            getForecastWeatherUseCase:
                GetForecastWeatherUseCase(weatherRepository: bc.read()),
          ),
        );
      },
    );
  }
}