import 'package:equatable/equatable.dart';

abstract class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object?> get props => [];
}

class TrackingStarted extends TrackingEvent {
  const TrackingStarted();
}

class TrackingStopped extends TrackingEvent {
  const TrackingStopped();
}

class TrackingFilterChanged extends TrackingEvent {
  final int limit;

  const TrackingFilterChanged(this.limit);

  @override
  List<Object?> get props => [limit];
}

/// Internal event fired every 5 seconds.
/// Never dispatched by the UI.
class TrackingTick extends TrackingEvent {
  const TrackingTick();
}
