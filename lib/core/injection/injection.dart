import 'package:get_it/get_it.dart';

import '../services/local_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<LocalStorageService>(
      () => LocalStorageServiceImpl());

  // // Data sources
  // sl.registerLazySingleton<AuthLocalDataSource>(
  //   () => AuthLocalDataSourceImpl(storageService: sl()),
  // );
  // sl.registerLazySingleton<CitizenLocalDataSource>(
  //   () => CitizenLocalDataSourceImpl(storageService: sl()),
  // );
  // sl.registerLazySingleton<AdminLocalDataSource>(
  //   () => AdminLocalDataSourceImpl(storageService: sl()),
  // );

  // // Repositories
  // sl.registerLazySingleton<AuthRepository>(
  //   () => AuthRepositoryImpl(localDataSource: sl()),
  // );
  // sl.registerLazySingleton<CitizenRepository>(
  //   () => CitizenRepositoryImpl(localDataSource: sl()),
  // );
  // sl.registerLazySingleton<AdminRepository>(
  //   () => AdminRepositoryImpl(localDataSource: sl()),
  // );

  // // Use cases - Auth
  // sl.registerLazySingleton(() => LoginAdmin(sl()));
  // sl.registerLazySingleton(() => LogoutAdmin(sl()));
  // sl.registerLazySingleton(() => GetCurrentSession(sl()));

  // // Use cases - Citizen
  // sl.registerLazySingleton(() => RegisterCitizen(sl()));
  // sl.registerLazySingleton(() => SubmitServiceRequest(sl()));
  // sl.registerLazySingleton(() => GetCitizenRequests(sl()));

  // // Use cases - Admin
  // sl.registerLazySingleton(() => GetAllRequests(sl()));
  // sl.registerLazySingleton(() => UpdateRequestStatus(sl()));
  // sl.registerLazySingleton(() => GetRequestDetails(sl()));

  // // BLoC
  // sl.registerFactory(() => AuthBloc(
  //       loginAdmin: sl(),
  //       logoutAdmin: sl(),
  //       getCurrentSession: sl(),
  //     ));
  // sl.registerFactory(() => CitizenBloc(
  //       registerCitizen: sl(),
  //       submitServiceRequest: sl(),
  //       getCitizenRequests: sl(),
  //     ));
  // sl.registerFactory(() => AdminBloc(
  //       getAllRequests: sl(),
  //       updateRequestStatus: sl(),
  //       getRequestDetails: sl(),
  //     ));
}
