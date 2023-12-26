import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logging/logging.dart';
import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/risk.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';

import '../session_info.dart';
import 'secure_storage.dart';

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl() : _flutterSecureStorage = const FlutterSecureStorage();

  final Logger _logger = Logger('SecureStorage');
  final FlutterSecureStorage _flutterSecureStorage;

  bool? _isDarkMode;
  bool? _isFirstTime;
  SessionInfo? _sessionInfo;
  WorkCenter? _workCenter;
  Inspection? _inspection;
  Area? _area;
  Risk? _risk;
  User? _user;

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

  @override
  Future<void> storeUser(User user) async {
    await _save(
      key: _AttributesKeys.userData,
      value: json.encode(User.toMap(user)),
    );
  }

  @override
  Future<void> storeWorkCenterId(WorkCenter workCenter) async {
    await _save(
      key: _AttributesKeys.workCenterId,
      value: json.encode(WorkCenter.toMap(workCenter)),
    );
  }

  @override
  Future<void> storeInspection(Inspection workCenter) async {
    await _save(
      key: _AttributesKeys.inspection,
      value: json.encode(Inspection.toMap(workCenter)),
    );
  }

  @override
  Future<void> storeArea(Area area) async {
    await _save(
      key: _AttributesKeys.area,
      value: json.encode(Area.toMap(area)),
    );
  }

  @override
  Future<void> storeRisk(Risk risk) async {
    await _save(
      key: _AttributesKeys.risk,
      value: json.encode(Risk.toMap(risk)),
    );
  }

  @override
  Future<bool> logout() async {
    try {
      await _reset();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Area?> getArea() async {
    final areaInfo = await _load(
      key: _AttributesKeys.area,
    );

    if (areaInfo?.isNotEmpty == true) {
      _area = Area.fromMap(
        json.decode(areaInfo!),
      );
    }
    return _area;
  }

  @override
  Future<Inspection?> getInspection() async {
    final inspectionInfo = await _load(
      key: _AttributesKeys.inspection,
    );

    if (inspectionInfo?.isNotEmpty == true) {
      _inspection = Inspection.fromMap(
        json.decode(inspectionInfo!),
      );
    }
    return _inspection;
  }

  @override
  Future<Risk?> getRisk() async {
    final riskInfo = await _load(
      key: _AttributesKeys.risk,
    );

    if (riskInfo?.isNotEmpty == true) {
      _risk = Risk.fromMap(
        json.decode(riskInfo!),
      );
    }
    return _risk;
  }

  @override
  Future<User?> getUser() async {
    final userInfo = await _load(
      key: _AttributesKeys.userData,
    );

    if (userInfo?.isNotEmpty == true) {
      _user = User.fromMap(
        json.decode(userInfo!),
      );
    }
    return _user;
  }

  @override
  Future<WorkCenter?> getWorkCenter() async {
    final workCenterInfo = await _load(
      key: _AttributesKeys.workCenterId,
    );

    if (workCenterInfo?.isNotEmpty == true) {
      _workCenter = WorkCenter.fromMap(
        json.decode(workCenterInfo!),
      );
    }
    return _workCenter;
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

  Future<void> _reset() async {
    try {
      await _flutterSecureStorage.deleteAll();
    } catch (e, stack) {
      _logger.severe('Exception clearing secure storage', e, stack);
    }
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
  static const userData = 'userData';
  static const workCenterId = 'workCenterId';
  static const inspection = 'inspection';
  static const area = 'area';
  static const risk = 'risk';
}
