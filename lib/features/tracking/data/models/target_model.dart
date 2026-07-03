import '../../domain/entities/target.dart';

class TargetModel extends Target {
  const TargetModel({
    required super.id,
    required super.targetLat,
    required super.targetLng,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    return TargetModel(
      id: json['id'] as String,
      targetLat: (json['target_lat'] as num).toDouble(),
      targetLng: (json['target_lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'target_lat': targetLat, 'target_lng': targetLng};
  }
}
