import '../entities/target.dart';
import '../repositories/tracking_repository.dart';

class SaveTrackingRecord {
  final TrackingRepository repository;

  const SaveTrackingRecord(this.repository);

  Future<void> call({
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    required Target target,
  }) {
    return repository.saveTrackingRecord(
      timestamp: timestamp,
      latitude: latitude,
      longitude: longitude,
      target: target,
    );
  }
}
