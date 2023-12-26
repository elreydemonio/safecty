import 'package:safecty/model/repository/model/area.dart';
import 'package:safecty/model/repository/model/inspection.dart';
import 'package:safecty/model/repository/model/risk.dart';
import 'package:safecty/model/repository/model/user.dart';
import 'package:safecty/model/repository/model/work_center.dart';

import '../session_info.dart';

abstract class SecureStorage {
  Future<void> changeTheme({
    required bool isDarkMode,
  });

  Future<bool> isDarkMode();

  Future<bool> isFirstTime();

  Future<SessionInfo?> getSessionInfo();

  Future<WorkCenter?> getWorkCenter();

  Future<Inspection?> getInspection();

  Future<Risk?> getRisk();

  Future<Area?> getArea();

  Future<User?> getUser();

  Future<bool> logout();

  Future<void> storeUser(User user);

  Future<void> storeWorkCenterId(WorkCenter workCenter);

  Future<void> storeInspection(Inspection workCenter);

  Future<void> storeArea(Area area);

  Future<void> storeRisk(Risk risk);
}
