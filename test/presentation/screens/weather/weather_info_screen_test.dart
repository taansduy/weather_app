import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:weather/core/utils/result.dart';
import 'package:weather/domain/entities/current/current_weather_info.dart';
import 'package:weather/domain/entities/forecast/forecast_weather_info.dart';
import 'package:weather/domain/usecase/get_current_weather_uc.dart';
import 'package:weather/domain/usecase/get_forecast_weather_uc.dart';
import 'package:weather/presentation/controllers/weather/weather_info_bloc.dart';
import 'package:weather/presentation/screens/weather/weather_info_screen.dart';
import 'package:weather/presentation/widgets/weather/weather_error_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_fetching_widget.dart';
import 'package:weather/presentation/widgets/weather/weather_info_widget.dart';

import '../../controllers/weather/weather_info_bloc_test.mocks.dart';



class MockWeatherInfoCubit extends WeatherInfoCubit {

  MockWeatherInfoCubit({
    required GetCurrentWeatherUseCase getCurrentWeatherUseCase,
    required GetForecastWeatherUseCase getForecastWeatherUseCase,
  }) : super(getCurrentWeatherUseCase: getCurrentWeatherUseCase, getForecastWeatherUseCase: getForecastWeatherUseCase);
    
}

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late MockGetForecastWeatherUseCase mockGetForecastWeatherUseCase;
  late MockWeatherInfoCubit mockWeatherInfoCubit;

  final testCurrentWeather = CurrentWeatherInfo(
    cityName: 'Test City',
    celciusTemp: 25,
  );

  final testForecastWeather = [
    ForecastWeatherInfo(
      celciusTemp: 26,
      date: DateTime.now().add(const Duration(days: 1)),
    ),
    ForecastWeatherInfo(
      celciusTemp: 24,
      date: DateTime.now().add(const Duration(days: 2)),
    ),
  ];

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    mockGetForecastWeatherUseCase = MockGetForecastWeatherUseCase();
    mockWeatherInfoCubit = MockWeatherInfoCubit(
      getCurrentWeatherUseCase: mockGetCurrentWeatherUseCase,
      getForecastWeatherUseCase: mockGetForecastWeatherUseCase,
    );
  });

  Widget buildTestWidget({WeatherInfoState? initialState}) {

    return MaterialApp(
      home: BlocProvider<WeatherInfoCubit>(
        create: (context) => mockWeatherInfoCubit,
        child: const WeatherInfoScreen(), 
      ),
    );
  }

  group('WeatherInfoScreen Tests', () {
    testWidgets('should show loading widget in initial state',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(buildTestWidget());

      // Assert
      expect(find.byType(WeatherFetchingWidget), findsOneWidget);
      expect(find.byType(WeatherInfoWidget), findsNothing);
      expect(find.byType(WeatherErrorWidget), findsNothing);
    });

    testWidgets('should show weather info widget when data is loaded successfully',
        (WidgetTester tester) async {

        when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testCurrentWeather));
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Success(testForecastWeather));
      // Arrange
      await tester.pumpWidget(buildTestWidget(),);

      // Act - Simulate location update
    
      
      mockWeatherInfoCubit.updateLocation(37.7749, -122.4194);
      await tester.pump();

      // Assert
      expect(find.byType(WeatherInfoWidget), findsOneWidget);
      expect(find.byType(WeatherFetchingWidget), findsNothing);
      expect(find.byType(WeatherErrorWidget), findsNothing);

      // Verify weather info is displayed correctly
      expect(find.text('Test City'), findsOneWidget);
      expect(find.text('25°'), findsOneWidget);
    });

    testWidgets('should show error widget when fetch fails',
        (WidgetTester tester) async {
      // Arrange
      const errorMessage = 'Something went wrong at our end!';
       when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure(errorMessage));
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure(errorMessage));
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(),
      );
      mockWeatherInfoCubit.updateLocation(37.7749, -122.4194);
      await tester.pump();



      // Assert
      expect(find.byType(WeatherErrorWidget), findsOneWidget);
      expect(find.byType(WeatherFetchingWidget), findsNothing);
      expect(find.byType(WeatherInfoWidget), findsNothing);
      expect(find.text(errorMessage), findsOneWidget);
    });

    testWidgets('should trigger retry when error widget retry button is tapped',
        (WidgetTester tester) async {
      // Arrange
       const errorMessage = 'Something went wrong at our end!';
       when(mockGetCurrentWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure(errorMessage));
      when(mockGetForecastWeatherUseCase.call(any))
          .thenAnswer((_) async => Failure(errorMessage));
      // Arrange
      await tester.pumpWidget(
        buildTestWidget(),
      );
      mockWeatherInfoCubit.updateLocation(37.7749, -122.4194);
      await tester.pump();

      // Act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Assert
      
      // verify(() => mockWeatherInfoCubit.fetchWeatherInfo()).called(1);
    });

    // testWidgets('should update location when position is received',
    //     (WidgetTester tester) async {
    //   // Arrange
    //   const testLat = 37.7749;
    //   const testLong = -122.4194;
    //   final mockPosition = MockPosition(
    //     latitude: testLat,
    //     longitude: testLong,
    //   );

    //   await tester.pumpWidget(buildTestWidget());

    //   // Simulate location ready callback
    //   final state = tester.state<_WeatherInfoScreenState>(
    //     find.byType(WeatherInfoScreen),
    //   );
    //   state.build(state.context); // Rebuild to trigger location callback

    //   // Act
    //   state.onLocationReady(mockPosition);

    //   // Assert
    //   verify(
    //     () => mockWeatherInfoCubit.updateLocation(testLat, testLong),
    //   ).called(1);
    // });
  });
} 