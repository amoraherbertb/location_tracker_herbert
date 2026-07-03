import 'dart:math';

import '../constants/app_constants.dart';

class HaversineService {
  const HaversineService();

  /// Calculates the distance between two coordinates in meters.
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    final lat1 = _degreesToRadians(startLatitude);
    final lon1 = _degreesToRadians(startLongitude);
    final lat2 = _degreesToRadians(endLatitude);
    final lon2 = _degreesToRadians(endLongitude);

    final deltaLat = lat2 - lat1;
    final deltaLon = lon2 - lon1;

    final a =
        pow(sin(deltaLat / 2), 2) +
        cos(lat1) * cos(lat2) * pow(sin(deltaLon / 2), 2);

    final c = 2 * atan2(sqrt(a.toDouble()), sqrt(1 - a.toDouble()));

    return AppConstants.earthRadiusInMeters * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
