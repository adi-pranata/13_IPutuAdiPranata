import 'package:get_it/get_it.dart';

import '../features/admin/presentation/pages/bloc/admin_bloc.dart';
import '../features/auth/data/datasources/auth_local_datasource.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repositiry.dart';
import '../features/auth/domain/usecases/auth_usecase.dart';
import '../features/citizen/data/repositories/citizen_repository_impl.dart';
import '../features/citizen/domain/repositories/citizen_repository.dart';
import '../features/citizen/domain/usecases/citizen_usecase.dart';
import '../features/citizen/presentation/bloc/citizen_bloc.dart';
import '../services/local_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<LocalStorageService>(
      () => LocalStorageServiceImpl());

  // Data sources
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storageService: sl()),
  );
  sl.registerLazySingleton<CitizenLocalDataSource>(
    () => CitizenLocalDataSourceImpl(storageService: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<CitizenRepository>(
    () => CitizenRepositoryImpl(localDataSource: sl()),
  );

  // Use cases - Auth
  sl.registerLazySingleton(() => LoginAdmin(sl()));
  sl.registerLazySingleton(() => LogoutAdmin(sl()));
  sl.registerLazySingleton(() => GetCurrentSession(sl()));

  // Use cases - Citizen
  sl.registerLazySingleton(() => RegisterCitizen(sl()));
  sl.registerLazySingleton(() => SubmitServiceRequest(sl()));
  sl.registerLazySingleton(() => GetCitizenRequests(sl()));

  // Use cases - Admin

  // BLoC
  sl.registerFactory(() => CitizenBloc(
        registerCitizen: sl(),
        submitServiceRequest: sl(),
        getCitizenRequests: sl(),
      ));
}
