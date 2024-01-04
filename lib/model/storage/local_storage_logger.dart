import 'package:logging/logging.dart';

class LocalStorageLogger {
  final Logger _logger = Logger((LocalStorageLogger).toString());

  void logStore({
    required String path,
    required String id,
    required String description,
  }) {
    _logger.info('''
    -------------------------------------------------------------
    - LOCAL STORAGE STORE -
    -------------------------------------------------------------
    Path: $path
    Id: $id
    Description: $description
    -------------------------------------------------------------''');
  }

  void logUpdate({
    required String path,
    required String id,
    required String description,
  }) {
    _logger.info('''
    -------------------------------------------------------------
    - LOCAL STORAGE UPDATE -
    -------------------------------------------------------------
    Path: $path
    Id: $id
    Description: $description
    -------------------------------------------------------------''');
  }

  void logDelete({
    required String path,
    required String id,
    required String description,
  }) {
    _logger.info('''
    -------------------------------------------------------------
    - LOCAL STORAGE DELETE -
    -------------------------------------------------------------
    Path: $path
    Id: $id
    Description: $description
    -------------------------------------------------------------''');
  }
}
