import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';

import '../session_info.dart';
import 'secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _flutterSecureStorage = const FlutterSecureStorage();

  final Logger _logger = Logger('SecureStorage');
  final FlutterSecureStorage _flutterSecureStorage;

  bool? _isDarkMode;
  bool? _isFirstTime;
  SessionInfo? _sessionInfo;

  @override
  Future<void> changeTheme({required bool isDarkMode}) async {
    await _save(
      key: _AttributesKeys.isDarkMode,
      value: isDarkMode.toString(),
    );

    _isDarkMode = isDarkMode;
  }

  @override
  Future<bool> isDarkMode() async {
    if (_isDarkMode == null) {
      final rawDarkMode = await _load(
        key: _AttributesKeys.isDarkMode,
      );

      _isDarkMode = rawDarkMode == 'true';
    }

    return _isDarkMode!;
  }

  @override
  Future<bool> isFirstTime() async {
    if (_isFirstTime == null) {
      final rawFirstTime = await _load(
        key: _AttributesKeys.isFirstTime,
      );

      _isFirstTime = rawFirstTime == null;
    }

    return _isFirstTime!;
  }

  @override
  Future<SessionInfo?> getSessionInfo() async {
    final rawSessionInfo = await _load(
      key: _AttributesKeys.sessionInfo,
    );

    if (rawSessionInfo?.isNotEmpty == true) {
      _sessionInfo = SessionInfo.fromMap(
        json.decode(
          rawSessionInfo!,
        ),
      );
    }
    return _sessionInfo;
  }

  Future<String?> _load({
    required String key,
  }) async {
    String? result;

    try {
      result = await _flutterSecureStorage.read(key: key);
    } catch (e, stack) {
      _logger.severe('Exception loading "$key" from secure storage', e, stack);
    }
    return result;
  }

  Future<void> _save({
    required String key,
    String? value,
  }) async {
    try {
      if (value?.isNotEmpty != true) {
        await _flutterSecureStorage.delete(key: key);
      } else {
        await _flutterSecureStorage.write(
          key: key,
          value: value,
        );
      }
    } catch (e, stack) {
      _logger.severe('Exception saving "$key" to secure storage', e, stack);
    }
  }
}

abstract class _AttributesKeys {
  static const sessionInfo = 'sessionInfo';
  static const isDarkMode = 'isDarkMode';
  static const isFirstTime = 'isFirstTime';
}
