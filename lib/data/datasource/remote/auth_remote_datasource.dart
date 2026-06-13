import '../../../core/errors/exceptions.dart';
import '../../../core/services/api_endpoint.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../models/user_model.dart';

// ── Abstract interface ────────────────────────────────────────────────────────
abstract class AuthRemoteDatasource {
  /// Sends credentials to the login endpoint.
  Future<UserModel> signIn({
    required String username,
    required String password,
  });

  /// Calls the logout endpoint.
  Future<bool> signOut();
}

// ── ApiServices implementation ───────────────────────────────────────────────
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl();

  @override
  Future<UserModel> signIn({
    required String username,
    required String password,
  }) async {
    final response = await ApiServices.post<UserModel>(
      UserModel.fromJson,
      ApiEndpoint.login,
      body: {'email': username, 'password': password},
      isBasic: true,
      showSuccessMessage: true,
    );
    if (response == null) {
      throw const ServerException('Invalid username or password.');
    }
    return response;
  }

  @override
  Future<bool> signOut() async {
    await LocalStorage.signOut();
    return true;
  }
}
