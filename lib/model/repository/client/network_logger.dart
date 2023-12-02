import 'package:logging/logging.dart';

class NetworkLogger {
  final Logger _logger = Logger((NetworkLogger).toString());

  void logRequest({
    String? body,
    required Map headers,
    required String method,
    required Uri uri,
  }) {
    _logger.fine('''
  -----------------------------------------
  - API REQUEST                     -
  -----------------------------------------
  URL: ${uri.toString()}
  Method: $method
  Headers: $headers
  Body: $body
  -----------------------------------------''');
  }

  void logResponse({
    required String body,
    required Map headers,
    required int statusCode,
  }) {
    _logger.fine('''
  -----------------------------------------
  - API RESPONSE                     -
  -----------------------------------------
  Status Code: $statusCode
  Headers: $headers
  Body: $body
  -----------------------------------------''');
  }
}
