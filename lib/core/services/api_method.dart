import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:assessment_quomodosoft/core/routes/app_routes.dart';
import '../utils/app_logger.dart';
import 'local_storage_service.dart';
import 'app_snackbar.dart';
import '../errors/common_error_model.dart';

final _log = appLogger(ApiMethod);

/// Returns headers for public (unauthenticated) requests.
Map<String, String> _basicHeaders() => {
  HttpHeaders.acceptHeader: 'application/json',
  HttpHeaders.contentTypeHeader: 'application/json',
};

/// Returns headers with Bearer token for authenticated requests.
Future<Map<String, String>> _bearerHeaders() async {
  final token = LocalStorage.getToken();
  return {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  };
}

/// Low-level HTTP wrapper.
class ApiMethod {
  final bool isBasic;
  const ApiMethod({required this.isBasic});

  String _prepareUrl(String url) {
    if (isBasic) return url;
    final token = LocalStorage.getToken();
    if (token == null || token.isEmpty) return url;
    try {
      final uri = Uri.parse(url);
      final Map<String, String> queryParams = Map.from(uri.queryParameters);
      queryParams['token'] = token;
      return uri.replace(queryParameters: queryParams).toString();
    } catch (e) {
      final separator = url.contains('?') ? '&' : '?';
      return '$url${separator}token=$token';
    }
  }

  // ── GET ────────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> get(
    String url, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 GET $url');
    try {
      final res = await http
          .get(
            Uri.parse(url),
            headers: isBasic ? _basicHeaders() : await _bearerHeaders(),
          )
          .timeout(Duration(seconds: duration));
      _log.i('|📒 GET ${res.statusCode}');
      if (showResult) _log.i(res.body);
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on GET $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } on TimeoutException {
      _log.e('TimeoutException on GET $url');
      if (showErrorMessage) {
        AppSnackBar.error('Request timed out. Please try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on GET $url: $e');
      return null;
    }
  }

  // ── POST ───────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> post(
    String url,
    Map<String, dynamic> body, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 POST $url | body: $body');
    try {
      final res = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? _basicHeaders() : await _bearerHeaders(),
          )
          .timeout(Duration(seconds: duration));
      _log.i('|📒 POST ${res.statusCode}');
      if (showResult) _log.i(res.body);
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on POST $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } on TimeoutException {
      _log.e('TimeoutException on POST $url');
      if (showErrorMessage) {
        AppSnackBar.error('Request timed out. Please try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on POST $url: $e');
      return null;
    }
  }

  // ── PUT ────────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> put(
    String url,
    Map<String, dynamic> body, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 PUT $url | body: $body');
    try {
      final res = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? _basicHeaders() : await _bearerHeaders(),
          )
          .timeout(Duration(seconds: duration));
      _log.i('|📒 PUT ${res.statusCode}');
      if (showResult) _log.i(res.body);
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on PUT $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } on TimeoutException {
      _log.e('TimeoutException on PUT $url');
      if (showErrorMessage) {
        AppSnackBar.error('Request timed out. Please try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on PUT $url: $e');
      return null;
    }
  }

  // ── DELETE ─────────────────────────────────────────────────────────────────
  Future<Map<String, dynamic>?> delete(
    String url, {
    int code = 200,
    int duration = 120,
    bool showResult = false,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 DELETE $url');
    try {
      final res = await http
          .delete(
            Uri.parse(url),
            headers: isBasic ? _basicHeaders() : await _bearerHeaders(),
          )
          .timeout(Duration(seconds: duration));
      _log.i('|📒 DELETE ${res.statusCode}');
      if (showResult) _log.i(res.body);
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on DELETE $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } on TimeoutException {
      _log.e('TimeoutException on DELETE $url');
      if (showErrorMessage) {
        AppSnackBar.error('Request timed out. Please try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on DELETE $url: $e');
      return null;
    }
  }

  // ── MULTIPART (single file) ────────────────────────────────────────────────
  Future<Map<String, dynamic>?> multipart(
    String url,
    Map<String, String> body,
    String filePath,
    String fieldName, {
    int code = 200,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 MULTIPART $url');
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(isBasic ? _basicHeaders() : await _bearerHeaders())
        ..files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);
      _log.i('|📒 MULTIPART ${res.statusCode}');
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on MULTIPART $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on MULTIPART $url: $e');
      return null;
    }
  }

  // ── MULTIPART (multiple files) ─────────────────────────────────────────────
  Future<Map<String, dynamic>?> multipartMultiFile(
    String url,
    Map<String, String> body, {
    required List<String> pathList,
    required List<String> fieldList,
    int code = 200,
    bool showErrorMessage = true,
  }) async {
    url = _prepareUrl(url);
    _log.i('|📍 MULTIPART-MULTI $url');
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(isBasic ? _basicHeaders() : await _bearerHeaders());
      for (int i = 0; i < fieldList.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath(fieldList[i], pathList[i]),
        );
      }
      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);
      _log.i('|📒 MULTIPART-MULTI ${res.statusCode}');
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException {
      _log.e('SocketException on MULTIPART-MULTI $url');
      if (showErrorMessage) {
        AppSnackBar.error('Check your internet connection and try again.');
      }
      return null;
    } catch (e) {
      _log.e('Unknown error on MULTIPART-MULTI $url: $e');
      return null;
    }
  }

  // ── Response Handler ───────────────────────────────────────────────────────
  Map<String, dynamic>? _handleResponse(
    http.Response res,
    int expectedCode,
    bool showErrorMessage,
  ) {
    // Unauthenticated — clear auth and go to login
    if (res.statusCode == 401) {
      LocalStorage.signOut();
      navigatorKey.currentState?.pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
      return null;
    }

    // Success (200 or 201)
    if (res.statusCode == 200 || res.statusCode == 201 || res.statusCode == 204) {
      if (res.body.isEmpty) {
        return {};
      }
      final decoded = jsonDecode(res.body);
      if (decoded is List) {
        return {'data': decoded};
      }
      return decoded as Map<String, dynamic>;
    }

    // Server error
    if (res.statusCode == 500) {
      if (showErrorMessage) {
        AppSnackBar.error('Internal server error. Please try again later.');
      }
      return null;
    }

    // Other errors — show backend message if available using CommonErrorModel
    _log.e('🐞 Unexpected status ${res.statusCode}: ${res.body}');
    if (showErrorMessage) {
      try {
        final decoded = jsonDecode(res.body) as Map<String, dynamic>;
        final errorModel = CommonErrorModel.fromJson(decoded);
        AppSnackBar.error(errorModel.message);
      } catch (e) {
        // Fallback for simple message or array
        try {
          final decoded = jsonDecode(res.body) as Map<String, dynamic>;
          final msg = decoded['message']?.toString() ?? 'Something went wrong.';
          AppSnackBar.error(msg);
        } catch (_) {
          AppSnackBar.error('Something went wrong.');
        }
      }
    }
    return null;
  }
}
