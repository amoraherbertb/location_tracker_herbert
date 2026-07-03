import 'package:hive_flutter/hive_flutter.dart';

import '../../models/tracking_record_model.dart';

abstract class TrackingLocalDataSource {
  Future<void> saveRecord(TrackingRecordModel record);

  Future<List<TrackingRecordModel>> getRecords();

  Future<void> clearRecords();
}

class TrackingLocalDataSourceImpl implements TrackingLocalDataSource {
  final Box<TrackingRecordModel> trackingBox;

  TrackingLocalDataSourceImpl(this.trackingBox);

  @override
  Future<void> saveRecord(TrackingRecordModel record) async {
    await trackingBox.add(record);
  }

  @override
  Future<List<TrackingRecordModel>> getRecords() async {
    return trackingBox.values.toList().reversed.toList();
  }

  @override
  Future<void> clearRecords() async {
    await trackingBox.clear();
  }
}
