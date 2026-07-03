import 'package:hive/hive.dart';

import '../../domain/entities/tracking_record.dart';

part 'tracking_record_model.g.dart';

@HiveType(typeId: 0)
class TrackingRecordModel extends TrackingRecord {
  @HiveField(0)
  final DateTime timestamp;

  @HiveField(1)
  final double latitude;

  @HiveField(2)
  final double longitude;

  @HiveField(3)
  final double distance;

  const TrackingRecordModel({
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.distance,
  }) : super(
         timestamp: timestamp,
         latitude: latitude,
         longitude: longitude,
         distance: distance,
       );

  factory TrackingRecordModel.fromEntity(TrackingRecord record) {
    return TrackingRecordModel(
      timestamp: record.timestamp,
      latitude: record.latitude,
      longitude: record.longitude,
      distance: record.distance,
    );
  }

  factory TrackingRecordModel.fromJson(Map<String, dynamic> json) {
    return TrackingRecordModel(
      timestamp: DateTime.parse(json['timestamp'] as String),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}
