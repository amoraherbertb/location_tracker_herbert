import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/services/permission_service.dart';

import '../../domain/entities/target.dart';
import '../../domain/usecases/fetch_target.dart';
import '../../domain/usecases/get_tracking_records.dart';
import '../../domain/usecases/save_tracking_record.dart';

import 'tracking_event.dart';
import 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final FetchTarget fetchTarget;
  final SaveTrackingRecord saveTrackingRecord;
  final GetTrackingRecords getTrackingRecords;

  final PermissionService permissionService;
  final LocationService locationService;

  Timer? _trackingTimer;

  Target? _target;

  TrackingBloc({
    required this.fetchTarget,
    required this.saveTrackingRecord,
    required this.getTrackingRecords,
    required this.permissionService,
    required this.locationService,
  }) : super(const TrackingState()) {
    on<TrackingStarted>(_onTrackingStarted);
    on<TrackingStopped>(_onTrackingStopped);
    on<TrackingFilterChanged>(_onFilterChanged);

    // Internal event fired every 5 seconds
    on<TrackingTick>(_onTrackingTick);
  }

  Future<void> _onTrackingStarted(
    TrackingStarted event,
    Emitter<TrackingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: TrackingStatus.loading, errorMessage: null));

      // Ensure location permission is granted
      await permissionService.checkLocationPermission();

      // Fetch target only once
      _target = await fetchTarget();

      emit(state.copyWith(status: TrackingStatus.tracking, target: _target));

      await _reloadRecords(emit);
      // Capture the first location immediately
      add(const TrackingTick());

      // Restart timer if already running
      _trackingTimer?.cancel();

      _trackingTimer = Timer.periodic(
        AppConstants.trackingInterval,
        (_) => add(const TrackingTick()),
      );
    } catch (e, stackTrace) {
      emit(
        state.copyWith(
          status: TrackingStatus.failure,
          errorMessage: e.toString(),
        ),
      );

      addError(e, stackTrace);
    }
  }

  Future<void> _onTrackingStopped(
    TrackingStopped event,
    Emitter<TrackingState> emit,
  ) async {
    _trackingTimer?.cancel();
    _trackingTimer = null;

    emit(state.copyWith(status: TrackingStatus.stopped));
  }

  Future<void> _onFilterChanged(
    TrackingFilterChanged event,
    Emitter<TrackingState> emit,
  ) async {
    emit(state.copyWith(selectedFilter: event.limit));

    await _reloadRecords(emit);
  }

  Future<void> _onTrackingTick(
    TrackingTick event,
    Emitter<TrackingState> emit,
  ) async {
    if (_target == null) {
      return;
    }

    try {
      final Position position = await locationService.getCurrentLocation();

      await saveTrackingRecord(
        timestamp: DateTime.now(),
        latitude: position.latitude,
        longitude: position.longitude,
        target: _target!,
      );

      await _reloadRecords(emit);
    } catch (e, stackTrace) {
      emit(
        state.copyWith(
          status: TrackingStatus.failure,
          errorMessage: e.toString(),
        ),
      );

      addError(e, stackTrace);
    }
  }

  Future<void> _reloadRecords(Emitter<TrackingState> emit) async {
    final records = await getTrackingRecords(limit: state.selectedFilter);

    emit(state.copyWith(records: records));
  }

  @override
  Future<void> close() async {
    _trackingTimer?.cancel();
    await super.close();
  }
}
