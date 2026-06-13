import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/usecases/create_service_usecase.dart';
import '../../../domain/usecases/delete_service_usecase.dart';
import '../../../domain/usecases/get_services_usecase.dart';
import '../../../domain/usecases/update_service_usecase.dart';

part 'service_state.dart';

/// Cubit that drives the Service List, Create, and Update screens.
///
/// Usage (in ServiceListScreen):
///   `context.read<ServiceCubit>().loadServices();`
///
/// Injected via get_it:
///   `sl<ServiceCubit>()`
class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit({
    required GetServicesUseCase getServicesUseCase,
    required CreateServiceUseCase createServiceUseCase,
    required UpdateServiceUseCase updateServiceUseCase,
    required DeleteServiceUseCase deleteServiceUseCase,
  })  : _getServices = getServicesUseCase,
        _createService = createServiceUseCase,
        _updateService = updateServiceUseCase,
        _deleteService = deleteServiceUseCase,
        super(const ServiceInitial());

  final GetServicesUseCase _getServices;
  final CreateServiceUseCase _createService;
  final UpdateServiceUseCase _updateService;
  final DeleteServiceUseCase _deleteService;

  // ── Load ──────────────────────────────────────────────────────────────────
  /// Fetches all services (remote-first, cache-fallback).
  Future<void> loadServices() async {
    emit(const ServiceLoading());

    final result = await _getServices();
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (services) => emit(ServiceLoaded(services)),
    );
  }

  // ── Create ────────────────────────────────────────────────────────────────
  /// Publishes a new [service] and reloads the list on success.
  Future<void> createService(ServiceEntity service) async {
    emit(const ServiceLoading());

    final result = await _createService(service);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) {
        emit(const ServiceOperationSuccess('Service published successfully!'));
        loadServices();
      },
    );
  }

  // ── Update ────────────────────────────────────────────────────────────────
  /// Updates an existing [service] and reloads the list on success.
  Future<void> updateService(ServiceEntity service) async {
    emit(const ServiceLoading());

    final result = await _updateService(service);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) {
        emit(const ServiceOperationSuccess('Service updated successfully!'));
        loadServices();
      },
    );
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  /// Deletes the service with [id] and reloads the list on success.
  Future<void> deleteService(String id) async {
    final result = await _deleteService(id);
    result.fold(
      (failure) => emit(ServiceError(failure.message)),
      (_) {
        emit(const ServiceOperationSuccess('Service deleted successfully!'));
        loadServices();
      },
    );
  }
}
