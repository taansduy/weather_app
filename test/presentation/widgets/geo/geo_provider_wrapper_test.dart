import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:weather/presentation/widgets/geo/geo_provider_wrapper.dart';

class MockGeolocatorPlatform extends GeolocatorPlatform {
  final bool locationServiceEnabled;
  final LocationPermission permission;
  final Position currentPosition;
  final bool openSettings;

  MockGeolocatorPlatform({
    this.locationServiceEnabled = true,
    this.permission = LocationPermission.always,
    required this.currentPosition,
    this.openSettings = false,
  });

  @override
  Future<bool> isLocationServiceEnabled() async => locationServiceEnabled;

  @override
  Future<LocationPermission> checkPermission() async => permission;

  @override
  Future<LocationPermission> requestPermission() async => permission;

  @override
  Future<Position> getCurrentPosition({
    LocationSettings? locationSettings,
  }) async {
    return currentPosition;
  }

  @override
  Future<bool> openLocationSettings() async => true;
}

void main() {
  late MockGeolocatorPlatform mockGeolocatorPlatform;
  late Position mockPosition;

  setUp(() {

    mockPosition = Position(
      latitude: 37.7749,
      longitude: -122.4194,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  });

  Widget buildTestWidget({
    required void Function(Position) onLocationReady,
    VoidCallback? onLocationServiceDisabled,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: GeoProviderWrapper(
          onLocationReady: onLocationReady,
          onLocationServiceDisabled: onLocationServiceDisabled,
          child: const Text('Test Child'),
        ),
      ),
    );
  }

  group('GeoProviderWrapper Tests', () {
    testWidgets('should render child widget', (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: true,
        permission: LocationPermission.always,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;
      // Arrange & Act
      await tester.pumpWidget(
        buildTestWidget(onLocationReady: (_) {}),
      );

      // Assert
      expect(find.text('Test Child'), findsOneWidget);
    });

    testWidgets('should call onLocationReady when permissions are granted',
        (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: true,
        permission: LocationPermission.always,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;
      // Arrange
      Position? receivedPosition;
      // Act
      await tester.pumpWidget(
        buildTestWidget(
          onLocationReady: (position) {
            receivedPosition = position;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(receivedPosition, isNotNull);
      expect(receivedPosition?.latitude, equals(37.7749));
      expect(receivedPosition?.longitude, equals(-122.4194));
    });

    testWidgets('should show dialog when location service is disabled',
        (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: false,
        permission: LocationPermission.always,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;
      

      // Act
      await tester.pumpWidget(
        buildTestWidget(onLocationReady: (_) {}),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Location Service Disabled'), findsOneWidget);
      expect(
        find.text('Location serivce is not available to use this app'),
        findsOneWidget,
      );
    });

    testWidgets('should call onLocationServiceDisabled when provided',
        (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: false,
        permission: LocationPermission.always,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;
      // Arrange
      bool callbackCalled = false;

      // Act
      await tester.pumpWidget(
        buildTestWidget(
          onLocationReady: (_) {},
          onLocationServiceDisabled: () {
            callbackCalled = true;
          },
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(callbackCalled, isTrue);
      expect(find.text('Location Service Disabled'), findsNothing);
    });

    testWidgets('should show dialog when permission is denied',
        (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: true,
        permission: LocationPermission.denied,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;


      // Act
      await tester.pumpWidget(
        buildTestWidget(onLocationReady: (_) {}),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Location Permission Denied'), findsOneWidget);
      expect(
        find.text('Please enable location permission to continue'),
        findsOneWidget,
      );
    });

    testWidgets('should show dialog when permission is denied forever',
        (WidgetTester tester) async {
      mockGeolocatorPlatform = MockGeolocatorPlatform(
        locationServiceEnabled: true,
        permission: LocationPermission.deniedForever,
        currentPosition: mockPosition,
      );
      GeolocatorPlatform.instance = mockGeolocatorPlatform;
      // Act
      await tester.pumpWidget(
        buildTestWidget(onLocationReady: (_) {}),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Location Permission Denied'), findsOneWidget);
      expect(
        find.text('Please enable location permission to continue'),
        findsOneWidget,
      );
    });
  });
} 