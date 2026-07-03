abstract class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class PermissionException extends AppException {
  const PermissionException(super.message);
}

class LocationException extends AppException {
  const LocationException(super.message);
}

class CacheException extends AppException {
  const CacheException(super.message);
}

class DataSourceException extends AppException {
  const DataSourceException(super.message);
}
