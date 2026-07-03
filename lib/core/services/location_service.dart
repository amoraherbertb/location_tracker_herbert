import 'dart:async';

import 'package:geolocator/geolocator.dart';

import '../constants/app_constants.dart';

class LocationService {
  const LocationService();

  /// Returns the device's current location.
  Future<Position> getCurrentLocation() async {
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
  }

  /// Emits the current location at the specified interval.
  Stream<Position> getLocationStream({
    Duration interval = AppConstants.trackingInterval,
  }) {
    return Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 0,
        timeLimit: interval,
      ),
    );
  }
}
