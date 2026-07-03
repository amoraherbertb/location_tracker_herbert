import '../entities/tracking_record.dart';
import '../repositories/tracking_repository.dart';

class GetTrackingRecords {
  final TrackingRepository repository;

  const GetTrackingRecords(this.repository);

  Future<List<TrackingRecord>> call({int? limit}) {
    return repository.getTrackingRecords(limit: limit);
  }
}
