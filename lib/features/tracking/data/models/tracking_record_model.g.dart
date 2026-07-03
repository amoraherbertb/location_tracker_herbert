// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tracking_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrackingRecordModelAdapter extends TypeAdapter<TrackingRecordModel> {
  @override
  final int typeId = 0;

  @override
  TrackingRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrackingRecordModel(
      timestamp: fields[0] as DateTime,
      latitude: fields[1] as double,
      longitude: fields[2] as double,
      distance: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TrackingRecordModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.timestamp)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackingRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
