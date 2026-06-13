part of 'service_cubit.dart';

/// States for the service CRUD flow.
abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object?> get props => [];
}

/// Initial state — no data loaded.
class ServiceInitial extends ServiceState {
  const ServiceInitial();
}

/// Loading — API call in progress.
class ServiceLoading extends ServiceState {
  const ServiceLoading();
}

/// Successfully loaded a list of services.
class ServiceLoaded extends ServiceState {
  const ServiceLoaded(this.services);

  final List<ServiceEntity> services;

  @override
  List<Object?> get props => [services];
}

/// An operation (create/update/delete) completed successfully.
class ServiceOperationSuccess extends ServiceState {
  const ServiceOperationSuccess(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// An error occurred.
class ServiceError extends ServiceState {
  const ServiceError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
