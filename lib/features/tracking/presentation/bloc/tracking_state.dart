import 'package:equatable/equatable.dart';

import '../../domain/entities/target.dart';
import '../../domain/entities/tracking_record.dart';

enum TrackingStatus { initial, loading, tracking, stopped, success, failure }

class TrackingState extends Equatable {
  final TrackingStatus status;

  final Target? target;

  final List<TrackingRecord> records;

  final int selectedFilter;

  final String? errorMessage;

  const TrackingState({
    this.status = TrackingStatus.initial,
    this.target,
    this.records = const [],
    this.selectedFilter = 5,
    this.errorMessage,
  });

  TrackingState copyWith({
    TrackingStatus? status,
    Target? target,
    List<TrackingRecord>? records,
    int? selectedFilter,
    String? errorMessage,
  }) {
    return TrackingState(
      status: status ?? this.status,
      target: target ?? this.target,
      records: records ?? this.records,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    target,
    records,
    selectedFilter,
    errorMessage,
  ];
}
