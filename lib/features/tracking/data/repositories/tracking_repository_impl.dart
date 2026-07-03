import '../../../../core/services/haversine_service.dart';

import '../../domain/entities/target.dart';
import '../../domain/entities/tracking_record.dart';
import '../../domain/repositories/tracking_repository.dart';

import '../datasources/local/tracking_local_datasource.dart';
import '../datasources/remote/target_remote_datasource.dart';
import '../models/tracking_record_model.dart';

class TrackingRepositoryImpl implements TrackingRepository {
  final TargetRemoteDataSource remoteDataSource;
  final TrackingLocalDataSource localDataSource;
  final HaversineService haversineService;

  const TrackingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.haversineService,
  });

  @override
  Future<Target> fetchTarget() async {
    return remoteDataSource.fetchTarget();
  }

  @override
  Future<void> saveTrackingRecord({
    required DateTime timestamp,
    required double latitude,
    required double longitude,
    required Target target,
  }) async {
    final distance = haversineService.calculateDistance(
      startLatitude: latitude,
      startLongitude: longitude,
      endLatitude: target.targetLat,
      endLongitude: target.targetLng,
    );

    final record = TrackingRecordModel(
      timestamp: timestamp,
      latitude: latitude,
      longitude: longitude,
      distance: distance,
    );

    await localDataSource.saveRecord(record);
  }

  @override
  Future<List<TrackingRecord>> getTrackingRecords({int? limit}) async {
    final records = await localDataSource.getRecords();

    if (limit == null || records.length <= limit) {
      return records;
    }

    return records.take(limit).toList();
  }

  @override
  Future<void> clearTrackingRecords() async {
    await localDataSource.clearRecords();
  }
}
