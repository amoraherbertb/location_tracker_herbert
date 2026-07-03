import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/constants/app_constants.dart';
import 'core/services/haversine_service.dart';
import 'core/services/location_service.dart';
import 'core/services/permission_service.dart';

import 'features/tracking/data/datasources/local/tracking_local_datasource.dart';
import 'features/tracking/data/datasources/remote/target_remote_datasource.dart';
import 'features/tracking/data/models/tracking_record_model.dart';
import 'features/tracking/data/repositories/tracking_repository_impl.dart';

import 'features/tracking/domain/repositories/tracking_repository.dart';
import 'features/tracking/domain/usecases/fetch_target.dart';
import 'features/tracking/domain/usecases/get_tracking_records.dart';
import 'features/tracking/domain/usecases/save_tracking_record.dart';

import 'features/tracking/presentation/bloc/tracking_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //
  // Hive
  //
  await Hive.initFlutter();

  Hive.registerAdapter(TrackingRecordModelAdapter());

  final trackingBox = await Hive.openBox<TrackingRecordModel>(
    AppConstants.trackingBox,
  );

  sl.registerLazySingleton<Box<TrackingRecordModel>>(() => trackingBox);

  //
  // Core Services
  //
  sl.registerLazySingleton<LocationService>(() => const LocationService());

  sl.registerLazySingleton<PermissionService>(() => const PermissionService());

  sl.registerLazySingleton<HaversineService>(() => const HaversineService());

  //
  // Data Sources
  //
  sl.registerLazySingleton<TargetRemoteDataSource>(
    () => const TargetRemoteDataSourceImpl(),
  );

  sl.registerLazySingleton<TrackingLocalDataSource>(
    () => TrackingLocalDataSourceImpl(sl()),
  );

  //
  // Repository
  //
  sl.registerLazySingleton<TrackingRepository>(
    () => TrackingRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      haversineService: sl(),
    ),
  );

  //
  // Use Cases
  //
  sl.registerLazySingleton(() => FetchTarget(sl()));

  sl.registerLazySingleton(() => SaveTrackingRecord(sl()));

  sl.registerLazySingleton(() => GetTrackingRecords(sl()));

  //
  // Bloc
  //
  sl.registerFactory(
    () => TrackingBloc(
      fetchTarget: sl(),
      saveTrackingRecord: sl(),
      getTrackingRecords: sl(),
      permissionService: sl(),
      locationService: sl(),
    ),
  );
}
