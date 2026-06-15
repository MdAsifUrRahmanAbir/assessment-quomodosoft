import '../../../core/errors/exceptions.dart';
import '../../../core/services/api_endpoint.dart';
import '../../../core/services/api_service.dart';
import '../../../domain/entities/category_entity.dart';
import '../../models/service_model.dart';

// ── Abstract interface ────────────────────────────────────────────────────────
abstract class ServiceRemoteDatasource {
  Future<List<ServiceModel>> getServices({int page = 1});
  Future<ServiceModel> getServiceById(String id);
  Future<ServiceModel> createService(ServiceModel service);
  Future<ServiceModel> updateService(ServiceModel service);
  Future<bool> deleteService(String id);
  Future<List<CategoryEntity>> getCategories();
}

// ── ApiServices implementation ───────────────────────────────────────────────
class ServiceRemoteDatasourceImpl implements ServiceRemoteDatasource {
  ServiceRemoteDatasourceImpl();

  @override
  Future<List<ServiceModel>> getServices({int page = 1}) async {
    // Replace hardcoded page parameter dynamically
    final path = ApiEndpoint.serviceList.replaceAll('page=1', 'page=$page');
    
    final response = await ApiServices.get<List<ServiceModel>>(
      (json) {
        // Extract from nested 'services' object if paginated, fallback to root otherwise
        final Map<String, dynamic> servicesMap = json['services'] as Map<String, dynamic>? ?? json;
        final data = servicesMap['data'] as List?;
        if (data == null) return [];
        return data
            .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
            .toList();
      },
      path,
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
    final categoryId = int.tryParse(service.category) ?? 8;
    final cleanSlug = service.title
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^a-z0-9\-]'), '');

    final Map<String, String> body = {
      'name': service.title,
      'slug': cleanSlug,
      'price': service.price.toString(),
      'category_id': categoryId.toString(),
      'description': service.description,
    };

    for (int i = 0; i < service.features.length; i++) {
      if (i == 0) {
        body['package_features[0]'] = service.features[0];
      } else {
        body['package_features[]'] = service.features[i];
      }
    }

    final response = await ApiServices.multipart<ServiceModel>(
      ServiceModel.fromJson,
      ApiEndpoint.serviceStore,
      body,
      fieldList: ['image'],
      pathList: [service.imageUrl],
    );

    if (response == null) {
      throw const ServerException('Failed to create service.');
    }
    return response;
  }

  @override
  Future<ServiceModel> updateService(ServiceModel service) async {
    final categoryId = int.tryParse(service.category) ?? 8;
    final cleanSlug = service.title
        .toLowerCase()
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'[^a-z0-9\-]'), '');

    final Map<String, String> body = {
      'name': service.title,
      'slug': cleanSlug,
      'price': service.price.toString(),
      'category_id': categoryId.toString(),
      'description': service.description,
      if (service.translateId != null) 'translate_id': service.translateId!.toString(),
    };

    final List<String> fieldList = [];
    final List<String> pathList = [];

    // If the imageUrl is a local file path, upload it as a file
    if (service.imageUrl.isNotEmpty && !service.imageUrl.startsWith('http')) {
      fieldList.add('image');
      pathList.add(service.imageUrl);
    }

    final response = await ApiServices.multipart<ServiceModel>(
      ServiceModel.fromJson,
      ApiEndpoint.serviceUpdate.replaceAll('{id}', service.id),
      body,
      fieldList: fieldList,
      pathList: pathList,
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

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await ApiServices.get<List<CategoryEntity>>(
      (json) {
        final list = json['categories'] as List?;
        if (list == null) return [];
        return list.map((e) {
          final map = e as Map<String, dynamic>;
          return CategoryEntity(
            id: map['id'] as int,
            name: map['name'] as String,
          );
        }).toList();
      },
      ApiEndpoint.serviceCreateInfo,
    );
    if (response == null) {
      throw const ServerException('Failed to fetch categories.');
    }
    return response;
  }
}
