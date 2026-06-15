import 'package:get_it/get_it.dart';

import '../services/local_storage_service.dart';
import '../../data/datasource/remote/auth_remote_datasource.dart';
import '../../data/datasource/remote/service_remote_datasource.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../data/repository/service_repository_impl.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/service_repository.dart';
import '../../domain/usecases/create_service_usecase.dart';
import '../../domain/usecases/delete_service_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_service_by_id_usecase.dart';
import '../../domain/usecases/get_services_usecase.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/update_service_usecase.dart';
import '../../presentation/bloc/auth/sign_in_cubit.dart';
import '../../presentation/bloc/service/service_cubit.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Registers all dependencies in the correct order:
/// 1. Initialize static services (LocalStorage)
/// 2. Data sources
/// 3. Repositories
/// 4. Use cases
/// 5. Cubits
///
/// Call once in [main] before [runApp]:
///   await initDependencies();
Future<void> initDependencies() async {
  // ── 1. Static Services ──────────────────────────────────────────────────────
  await LocalStorage.init();

  // ── 2. Data sources ────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(),
  );

  sl.registerLazySingleton<ServiceRemoteDatasource>(
    () => ServiceRemoteDatasourceImpl(),
  );

  // ── 3. Repositories ────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton<ServiceRepository>(
    () => ServiceRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );

  // ── 4. Use cases ───────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => GetServicesUseCase(sl()));
  sl.registerLazySingleton(() => CreateServiceUseCase(sl()));
  sl.registerLazySingleton(() => UpdateServiceUseCase(sl()));
  sl.registerLazySingleton(() => DeleteServiceUseCase(sl()));
  sl.registerLazySingleton(() => GetCategoriesUseCase(sl()));
  sl.registerLazySingleton(() => GetServiceByIdUseCase(sl()));

  // ── 5. Cubits ──────────────────────────────────────────────────────────────
  sl.registerFactory<SignInCubit>(() => SignInCubit());

  sl.registerFactory<ServiceCubit>(
    () => ServiceCubit(
      getServicesUseCase: sl(),
      createServiceUseCase: sl(),
      updateServiceUseCase: sl(),
      deleteServiceUseCase: sl(),
      getCategoriesUseCase: sl(),
      getServiceByIdUseCase: sl(),
    ),
  );
}
