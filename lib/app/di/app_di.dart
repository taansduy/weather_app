import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:weather/core/network/base_dio_client.dart';
import 'package:weather/data/datasource/remote/remote_weather_ds.dart';
import 'package:weather/data/repositories/weather_repository_impl.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

List<SingleChildWidget> dataSourcesProviders = [
  Provider<WeatherDataSource>(
    create: (context) => RemoteWeatherDataSource(dioClient: context.read()),
  ),
];

List<SingleChildWidget> repositoriesProviders = [
  Provider<WeatherRepository>(
    create: (context) => WeatherRepositoryImpl(weatherDataSource: context.read()),
  ),
];
