import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/network/weather_app_dio_client.dart';
import 'package:weather/main.dart';

void main() {
  testWidgets('App should render correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Flutter Demo'), findsOneWidget);
    expect(find.text('Flutter Demo Home Page'), findsOneWidget);

    // Verify that the counter starts at 0
    expect(find.text('0'), findsOneWidget);

    // Tap the increment button
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the counter has incremented
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('App should have correct theme', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify Material 3 is enabled
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.theme?.useMaterial3, true);

    // Verify color scheme
    expect(app.theme?.colorScheme.primary, Colors.deepPurple);
  });

  testWidgets('App should have Provider setup', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Verify that WeatherAppDioClient is provided
    final context = tester.element(find.byType(MaterialApp));
    expect(Provider.of<WeatherAppDioClient>(context, listen: false), isNotNull);
  });
} 