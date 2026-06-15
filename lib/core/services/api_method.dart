import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:assessment_quomodosoft/core/routes/app_routes.dart';
import '../utils/app_logger.dart';
import 'local_storage_service.dart';
import 'app_snackbar.dart';
import '../errors/exceptions.dart';

final _log = appLogger(ApiMethod);

// ── Sanitizers for terminal security ──────────────────────────────────────────
String _sanitizeUrl(String url) {
  try {
    final uri = Uri.parse(url);
    if (uri.queryParameters.containsKey('token')) {
      final params = Map<String, String>.from(uri.queryParameters);
      params['token'] = '***';
      return uri.replace(queryParameters: params).toString();
    }
  } catch (_) {}
  return url;
}

Map<String, dynamic> _sanitizeBody(Map<String, dynamic> body) {
  final Map<String, dynamic> sanitized = {};
  body.forEach((key, value) {
    if (key.toLowerCase().contains('password')) {
      sanitized[key] = '***';
    } else {
      sanitized[key] = value;
    }
  });
  return sanitized;
}

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

/// Low-level HTTP wrapper with custom exception throwing and DNS check.
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

  /// Evaluates connection status during host lookup failures.
  /// Resolves google.com to verify if the client has internet access.
  Future<Never> _handleSocketException(SocketException e, String url) async {
    _log.e('SocketException on ${_sanitizeUrl(url)}: $e');
    if (e.message.toLowerCase().contains('failed host lookup')) {
      try {
        final lookup = await InternetAddress.lookup('google.com')
            .timeout(const Duration(seconds: 2));
        if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
          throw const ServerException('Failed to resolve server host. Please check the domain address.');
        }
      } catch (_) {
        // google.com resolution failed; device is likely offline
      }
    }
    throw const NetworkException('Check your internet connection and try again.');
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
    _log.i('|📍 GET ${_sanitizeUrl(url)}');
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
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on GET ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on GET ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
    _log.i('|📍 POST ${_sanitizeUrl(url)} | body: ${_sanitizeBody(body)}');
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
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on POST ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on POST ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
    _log.i('|📍 PUT ${_sanitizeUrl(url)} | body: ${_sanitizeBody(body)}');
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
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on PUT ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on PUT ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
    _log.i('|📍 DELETE ${_sanitizeUrl(url)}');
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
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on DELETE ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on DELETE ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
    _log.i('|📍 MULTIPART ${_sanitizeUrl(url)}');
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url))
        ..fields.addAll(body)
        ..headers.addAll(isBasic ? _basicHeaders() : await _bearerHeaders())
        ..files.add(await http.MultipartFile.fromPath(fieldName, filePath));
      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);
      _log.i('|📒 MULTIPART ${res.statusCode}');
      return _handleResponse(res, code, showErrorMessage);
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on MULTIPART ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on MULTIPART ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
    _log.i('|📍 MULTIPART-MULTI ${_sanitizeUrl(url)}');
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
    } on SocketException catch (e) {
      await _handleSocketException(e, url);
    } on TimeoutException catch (e) {
      _log.e('TimeoutException on MULTIPART-MULTI ${_sanitizeUrl(url)}: $e');
      throw const NetworkException('Request timed out. Please try again.');
    } catch (e) {
      _log.e('Error on MULTIPART-MULTI ${_sanitizeUrl(url)}: $e');
      if (e is FormatException || e is ArgumentError) {
        throw const ServerException('Invalid URL or request format.');
      }
      if (e is NetworkException || e is ServerException || e is AuthException) {
        rethrow;
      }
      throw ServerException('Request failed: $e');
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
      String errorMsg = 'Unauthenticated. Please login again.';
      try {
        final decoded = jsonDecode(res.body) as Map<String, dynamic>;
        errorMsg = decoded['message']?.toString() ??
                   decoded['notification']?.toString() ??
                   decoded['error']?.toString() ??
                   'Unauthenticated. Please login again.';
      } catch (_) {}
      AppSnackBar.error(errorMsg);
      throw AuthException(errorMsg);
    }

    // Success (200, 201, 204)
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
    if (res.statusCode >= 500) {
      AppSnackBar.showServerErrorDialog();
      throw ServerException('Server error (${res.statusCode}). Please try again later.');
    }

    // Other client/server error codes (e.g. 400, 422, 403)
    _log.e('🐞 Unexpected status ${res.statusCode}: ${res.body}');
    String errorMsg = 'Something went wrong.';
    try {
      final decoded = jsonDecode(res.body) as Map<String, dynamic>;
      errorMsg = decoded['message']?.toString() ??
                 decoded['notification']?.toString() ??
                 decoded['error']?.toString() ??
                 'Something went wrong.';
    } catch (_) {
      try {
        if (res.body.isNotEmpty && res.body.length < 120) {
          errorMsg = res.body;
        }
      } catch (_) {}
    }
    throw ServerException(errorMsg);
  }
}
