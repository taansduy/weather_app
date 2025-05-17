import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoProviderWrapper extends StatefulWidget {
  final Widget child;
  final void Function(Position) onLocationReady;
  final VoidCallback? onLocationServiceDisabled;
  const GeoProviderWrapper(
      {super.key,
      required this.child,
      required this.onLocationReady,
      this.onLocationServiceDisabled});

  @override
  State<GeoProviderWrapper> createState() => _GeoProviderWrapperState();
}

class _GeoProviderWrapperState extends State<GeoProviderWrapper> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
  void initState() {
    checkLocationSerivce().then((isEnable) async {
      if (isEnable) {
        var hasLocationPermission = await _handlePermission();
        if (hasLocationPermission) {
          var position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
          widget.onLocationReady.call(position);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<bool> checkLocationSerivce() async {
    var _isLocationServiceEnabled =
        await _geolocatorPlatform.isLocationServiceEnabled();
    if (_isLocationServiceEnabled != true) {
      if (widget.onLocationServiceDisabled != null) {
        widget.onLocationServiceDisabled!.call();
      } else {
        showAdaptiveDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Location Service Disabled'),
                  content:
                      Text('Location serivce is not available to use this app'),
                ));
      }
    }
    return _isLocationServiceEnabled;
  }

  Future<bool> _handlePermission() async {
    LocationPermission permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        showAdaptiveDialog(
          context: context,
          barrierDismissible: false,
          builder: (bc) => AlertDialog(
                title: Text('Location Permission Denied'),
                content: Text('Please enable location permission to continue'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(bc);
                        _openLocationSettings();
                      },
                      child: Text('OK'))
                ],
              ));
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showAdaptiveDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Location Permission Denied'),
                content: Text('Please enable location permission to continue'),
                actions: [
                  TextButton(
                      onPressed: () {
                        _openLocationSettings();
                      },
                      child: Text('OK'))
                ],
              ));

      return false;
    }
    return true;
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
  }
}
