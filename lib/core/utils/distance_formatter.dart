class DistanceFormatter {
  DistanceFormatter._();

  /// Converts meters into a readable string.
  ///
  /// Examples:
  /// 125.4  -> 125 m
  /// 999.8  -> 1000 m
  /// 1200.5 -> 1.20 km
  /// 15234  -> 15.23 km
  static String format(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m';
    }

    final kilometers = meters / 1000;
    return '${kilometers.toStringAsFixed(2)} km';
  }
}
