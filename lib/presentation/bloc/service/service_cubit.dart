import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/category_entity.dart';
import '../../../domain/entities/service_entity.dart';
import '../../../domain/usecases/create_service_usecase.dart';
import '../../../domain/usecases/delete_service_usecase.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/get_service_by_id_usecase.dart';
import '../../../domain/usecases/get_services_usecase.dart';
import '../../../domain/usecases/update_service_usecase.dart';

part 'service_state.dart';

/// Cubit that drives the Service List, Create, and Update screens.
///
/// Injected via get_it:
///   `sl<ServiceCubit>()`
class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit({
    required GetServicesUseCase getServicesUseCase,
    required CreateServiceUseCase createServiceUseCase,
    required UpdateServiceUseCase updateServiceUseCase,
    required DeleteServiceUseCase deleteServiceUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
    required GetServiceByIdUseCase getServiceByIdUseCase,
  })  : _getServices = getServicesUseCase,
        _createService = createServiceUseCase,
        _updateService = updateServiceUseCase,
        _deleteService = deleteServiceUseCase,
        _getCategories = getCategoriesUseCase,
        _getServiceById = getServiceByIdUseCase,
        super(const ServiceInitial());

  final GetServicesUseCase _getServices;
  final CreateServiceUseCase _createService;
  final UpdateServiceUseCase _updateService;
  final DeleteServiceUseCase _deleteService;
  final GetCategoriesUseCase _getCategories;
  final GetServiceByIdUseCase _getServiceById;

  // ── Create Service Form State ──────────────────────────────────────────────
  final createFormKey = GlobalKey<FormState>();
  final createNameCtrl = TextEditingController();
  final createPriceCtrl = TextEditingController(text: '50');
  final createDescCtrl = TextEditingController();
  final List<TextEditingController> createFeatureCtrs = [
    TextEditingController(text: '4 Unique Header Style'),
  ];
  List<CategoryEntity> categories = [];
  CategoryEntity? selectedCategoryForCreate;
  String? selectedImagePathForCreate;
  bool loadingCategoriesForCreate = true;

  // ── Update Service Form State ──────────────────────────────────────────────
  final updateFormKey = GlobalKey<FormState>();
  final updateNameCtrl = TextEditingController();
  final updatePriceCtrl = TextEditingController();
  final updateDescCtrl = TextEditingController();
  final List<TextEditingController> updateFeatureCtrs = [];
  CategoryEntity? selectedCategoryForUpdate;
  String? selectedImagePathForUpdate;
  int? updateTranslateId;
  bool loadingDetailsForUpdate = true;
  late ServiceEntity editingService;

  // ── Figma Mock Services ───────────────────────────────────────────────────
  static const List<ServiceEntity> _mockServices = [
    ServiceEntity(
      id: 'mock-1',
      title: 'Confident experience smart recording video vlog',
      category: 'Vloggers',
      price: 188.0,
      rating: 4.5,
      reviewCount: 6,
      imageUrl: 'https://images.unsplash.com/photo-1616469829581-73993eb86b02?q=80&w=600&auto=format&fit=crop',
      date: '21 Sep, 2023',
      isActive: true,
      description: 'Confident experience smart recording video vlog. Perfect for vloggers and content creators.',
      features: ['High quality recording', '4K video output', 'Pro setup guide'],
    ),
    ServiceEntity(
      id: 'mock-2',
      title: 'Smart gym workout guide and bodybuilding training',
      category: 'Vloggers',
      price: 188.0,
      rating: 0.0,
      reviewCount: 0,
      imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=600&auto=format&fit=crop',
      date: '21 Sep, 2023',
      isActive: true,
      description: 'Smart gym workout guide for fitness enthusiasts. Comprehensive plans and exercise tutorials for all levels.',
      features: ['Custom workout plans', 'Nutrition guide', 'Progress tracker'],
    ),
  ];

  final List<ServiceEntity> _mockList = List.from(_mockServices);
  bool _hasDeletedMockServices = false;

  // ── Load ──────────────────────────────────────────────────────────────────
  /// Fetches all services (remote-first, mock-fallback if empty).
  Future<void> loadServices() async {
    emit(const ServiceLoading());

    final result = await _getServices(page: 1);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ServiceError(failure.message));
      },
      (services) {
        if (isClosed) return;
        if (services.isEmpty && !_hasDeletedMockServices) {
          emit(ServiceLoaded(_mockList, currentPage: 1, hasMore: false));
        } else {
          emit(ServiceLoaded(services, currentPage: 1, hasMore: services.length >= 15));
        }
      },
    );
  }

  /// Asynchronously loads the next page of services and appends them to current state list.
  Future<void> loadMoreServices() async {
    final currentState = state;
    if (currentState is! ServiceLoaded) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    emit(currentState.copyWith(isLoadingMore: true));

    final nextPage = currentState.currentPage + 1;
    final result = await _getServices(page: nextPage);

    result.fold(
      (failure) {
        if (isClosed) return;
        emit(currentState.copyWith(isLoadingMore: false));
      },
      (newServices) {
        if (isClosed) return;
        final updatedList = [...currentState.services, ...newServices];
        emit(ServiceLoaded(
          updatedList,
          currentPage: nextPage,
          hasMore: newServices.length >= 15,
          isLoadingMore: false,
        ));
      },
    );
  }

  // ── Create ────────────────────────────────────────────────────────────────
  /// Publishes a new [service] and reloads the list on success.
  Future<void> createService(ServiceEntity service) async {
    emit(const ServiceLoading());

    final result = await _createService(service);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ServiceError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(const ServiceOperationSuccess('Service published successfully!'));
        loadServices();
      },
    );
  }

  /// Fetches all active categories dynamically from the remote repository.
  Future<List<CategoryEntity>> getCategories() async {
    final result = await _getCategories();
    return result.fold(
      (failure) => [],
      (categories) => categories,
    );
  }

  /// Fetches service details by ID.
  Future<ServiceEntity?> getServiceById(String id) async {
    final result = await _getServiceById(id);
    return result.fold(
      (failure) => null,
      (service) => service,
    );
  }

  // ── Update ────────────────────────────────────────────────────────────────
  /// Updates an existing [service] and reloads the list on success.
  Future<void> updateService(ServiceEntity service) async {
    if (service.id.startsWith('mock-')) {
      emit(const ServiceLoading());
      final index = _mockList.indexWhere((s) => s.id == service.id);
      if (index != -1) {
        _mockList[index] = service;
      }
      emit(const ServiceOperationSuccess('Service updated successfully!'));
      emit(ServiceLoaded(_mockList, currentPage: 1, hasMore: false));
      return;
    }

    emit(const ServiceLoading());

    final result = await _updateService(service);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ServiceError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(const ServiceOperationSuccess('Service updated successfully!'));
        loadServices();
      },
    );
  }

  // ── Delete ────────────────────────────────────────────────────────────────
  /// Deletes the service with [id] and reloads the list on success.
  Future<void> deleteService(String id) async {
    if (id.startsWith('mock-')) {
      _hasDeletedMockServices = true;
      _mockList.removeWhere((s) => s.id == id);
      emit(const ServiceLoading());
      emit(const ServiceOperationSuccess('Service deleted successfully!'));
      emit(ServiceLoaded(_mockList, currentPage: 1, hasMore: false));
      return;
    }

    emit(const ServiceLoading());

    final result = await _deleteService(id);
    if (isClosed) return;
    result.fold(
      (failure) {
        if (isClosed) return;
        emit(ServiceError(failure.message));
      },
      (_) {
        if (isClosed) return;
        emit(const ServiceOperationSuccess('Service deleted successfully!'));
        loadServices();
      },
    );
  }

  @override
  Future<void> close() {
    createNameCtrl.dispose();
    createPriceCtrl.dispose();
    createDescCtrl.dispose();
    for (final c in createFeatureCtrs) {
      c.dispose();
    }
    updateNameCtrl.dispose();
    updatePriceCtrl.dispose();
    updateDescCtrl.dispose();
    for (final c in updateFeatureCtrs) {
      c.dispose();
    }
    return super.close();
  }
}
