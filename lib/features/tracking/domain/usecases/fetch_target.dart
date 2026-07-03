import '../entities/target.dart';
import '../repositories/tracking_repository.dart';

class FetchTarget {
  final TrackingRepository repository;

  const FetchTarget(this.repository);

  Future<Target> call() {
    return repository.fetchTarget();
  }
}
