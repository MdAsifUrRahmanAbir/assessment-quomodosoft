import '../../../core/errors/exceptions.dart';
import '../../../core/services/api_endpoint.dart';
import '../../../core/services/api_service.dart';
import '../../models/service_model.dart';

// ── Abstract interface ────────────────────────────────────────────────────────
abstract class ServiceRemoteDatasource {
  Future<List<ServiceModel>> getServices();
  Future<ServiceModel> getServiceById(String id);
  Future<ServiceModel> createService(ServiceModel service);
  Future<ServiceModel> updateService(ServiceModel service);
  Future<bool> deleteService(String id);
}

// ── ApiServices implementation ───────────────────────────────────────────────
class ServiceRemoteDatasourceImpl implements ServiceRemoteDatasource {
  ServiceRemoteDatasourceImpl();

  @override
  Future<List<ServiceModel>> getServices() async {
    final response = await ApiServices.get<List<ServiceModel>>(
      (json) {
        final data = json['data'] as List?;
        if (data == null) return [];
        return data
            .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      },
      ApiEndpoint.serviceList,
    );
    if (response == null) {
      throw const ServerException('Failed to fetch services.');
    }
    return response;
  }

  @override
  Future<ServiceModel> getServiceById(String id) async {
    final response = await ApiServices.get<ServiceModel>(
      ServiceModel.fromJson,
      ApiEndpoint.serviceEdit.replaceAll('{id}', id),
    );
    if (response == null) {
      throw const ServerException('Failed to fetch service.');
    }
    return response;
  }

  @override
  Future<ServiceModel> createService(ServiceModel service) async {
    final response = await ApiServices.post<ServiceModel>(
      ServiceModel.fromJson,
      ApiEndpoint.serviceStore,
      body: service.toJson(),
    );
    if (response == null) {
      throw const ServerException('Failed to create service.');
    }
    return response;
  }

  @override
  Future<ServiceModel> updateService(ServiceModel service) async {
    final response = await ApiServices.post<ServiceModel>(
      ServiceModel.fromJson,
      ApiEndpoint.serviceUpdate.replaceAll('{id}', service.id),
      body: service.toJson(),
    );
    if (response == null) {
      throw const ServerException('Failed to update service.');
    }
    return response;
  }

  @override
  Future<bool> deleteService(String id) async {
    final response = await ApiServices.delete<Map<String, dynamic>>(
      (json) => json,
      ApiEndpoint.serviceDelete.replaceAll('{id}', id),
    );
    return response != null;
  }
}
