class AppConstants {
  AppConstants._();

  // Location
  static const Duration trackingInterval = Duration(seconds: 5);

  // Distance
  static const double earthRadiusInMeters = 6371000;

  // Filter options
  static const List<int> filterOptions = [5, 10, 15, 20];
  static const int defaultFilter = 5;

  // Assets
  static const String targetJsonPath = 'assets/mock/target.json';

  // Hive
  static const String trackingBox = 'tracking_records';

  // Permissions
  static const String locationPermissionDenied = 'Location permission denied.';

  static const String locationPermissionDeniedForever =
      'Location permission permanently denied. Please enable it in Settings.';

  static const String locationServiceDisabled =
      'Location services are disabled. Please enable GPS.';

  // UI
  static const String appTitle = 'Location Tracker';
}
