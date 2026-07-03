import 'package:location_tracker_exam/features/tracking/domain/entities/target.dart';
import 'package:location_tracker_exam/features/tracking/domain/entities/tracking_record.dart';

abstract class TrackingRepository {
  Future<Target> fetchTarget();

  Future<void> saveTrackingRecord({
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    required Target target,
  });

  Future<List<TrackingRecord>> getTrackingRecords({int? limit});

  Future<void> clearTrackingRecords();
}
