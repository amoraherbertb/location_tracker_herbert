import 'package:geolocator/geolocator.dart';

import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class PermissionService {
  const PermissionService();

  /// Ensures location services are enabled and permission is granted.
  /// Throws an exception if the app cannot access the device location.
  Future<void> checkLocationPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw const LocationException(AppConstants.locationServiceDisabled);
    }

    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        throw const PermissionException(AppConstants.locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const PermissionException(
        AppConstants.locationPermissionDeniedForever,
      );
    }
  }

  /// Returns the current permission status.
  Future<LocationPermission> getPermissionStatus() {
    return Geolocator.checkPermission();
  }

  /// Opens the device's location settings.
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  /// Opens the application's settings page.
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }
}
