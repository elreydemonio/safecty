import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import '../../session_info.dart';
import '../../storage/secure_storage.dart';
import 'network_exception.dart';
import 'network_logger.dart';

enum PostMultiFormDataType {
  file,
  files,
}

class NetworkClient {
  NetworkClient({
    required Stream<ConnectivityResult> connectivityStream,
    required NetworkLogger networkLogger,
    required SecureStorage secureStorage,
  })  : _connectivityStream = connectivityStream,
        _networkLogger = networkLogger,
        _secureStorage = secureStorage;

  final Stream<ConnectivityResult> _connectivityStream;
  final _headers = {
    HttpHeaders.contentTypeHeader: ContentType.json.toString(),
  };
  final NetworkLogger _networkLogger;
  final SecureStorage _secureStorage;

  late bool _isOnline;

  Future<void> initialize({required bool isOnline}) async {
    _isOnline = isOnline;
    _connectivityStream.listen(
      (ConnectivityResult result) {
        _isOnline = result != ConnectivityResult.none;
      },
    );
  }

  Future<http.Response> get(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    _checkInternetConnection();

    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure(
        await _secureStorage.getSessionInfo(),
      );
    }

    final requestHeaders = _headers;
    if (headers?.isNotEmpty == true) {
      requestHeaders.addAll(headers ?? {});
    }

    _networkLogger.logRequest(
      headers: requestHeaders,
      method: 'GET',
      uri: uri,
    );

    final response = await http.get(
      uri,
      headers: requestHeaders,
    );

    _networkLogger.logResponse(
        body: response.body,
        headers: response.headers,
        statusCode: response.statusCode);

    return response;
  }

  Future<http.Response> post(
    Uri uri, {
    String? body,
    Map<String, String>? headers,
  }) async {
    _checkInternetConnection();

    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure(
        await _secureStorage.getSessionInfo(),
      );
    }

    final requestHeaders = _headers;
    if (headers?.isNotEmpty == true) {
      requestHeaders.addAll(headers ?? {});
    }

    _networkLogger.logRequest(
      body: body,
      headers: requestHeaders,
      method: 'POST',
      uri: uri,
    );

    final response = await http.post(
      uri,
      body: body,
      headers: requestHeaders,
    );

    _networkLogger.logResponse(
        body: response.body,
        headers: response.headers,
        statusCode: response.statusCode);

    return response;
  }

  Future<http.StreamedResponse> postMultiFormData(
    Uri uri, {
    required List<http.MultipartFile> listMultiPartFiles,
    Map<String, String>? headers,
    required PostMultiFormDataType type,
  }) async {
    _checkInternetConnection();

    if ((headers ?? const {})[HttpHeaders.authorizationHeader] == null) {
      _secure(
        await _secureStorage.getSessionInfo(),
      );
    }
    final requestHeaders = _headers;
    if (headers?.isNotEmpty == true) {
      requestHeaders.addAll(headers ?? {});
    }
    _networkLogger.logRequest(
      body: 'Send Images',
      headers: requestHeaders,
      method: 'SEND',
      uri: uri,
    );

    var request = http.MultipartRequest(
      'POST',
      uri,
    );

    request.headers.addAll(requestHeaders);

    switch (type) {
      case PostMultiFormDataType.file:
        request.files.add(listMultiPartFiles[0]);
        break;
      case PostMultiFormDataType.files:
        request.files.addAll(listMultiPartFiles);
        break;
    }

    var response = await request.send();

    var reponseBody = await response.stream.bytesToString();

    _networkLogger.logResponse(
        body: reponseBody,
        headers: response.headers,
        statusCode: response.statusCode);

    return response;
  }

  void _checkInternetConnection() {
    if (!_isOnline) {
      throw NetworkException();
    }
  }

  void _secure(SessionInfo? sessionInfo) {
    if (sessionInfo != null) {
      _headers[HttpHeaders.authorizationHeader] =
          'Bearer ${sessionInfo.accessToken}';
    }
  }
}
