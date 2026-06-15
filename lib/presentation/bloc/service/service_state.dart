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
  const ServiceLoaded(
    this.services, {
    this.currentPage = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final List<ServiceEntity> services;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;

  ServiceLoaded copyWith({
    List<ServiceEntity>? services,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return ServiceLoaded(
      services ?? this.services,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [services, currentPage, hasMore, isLoadingMore];
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
