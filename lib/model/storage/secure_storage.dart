import '../session_info.dart';

abstract class SecureStorage {
  Future<void> changeTheme({
    required bool isDarkMode,
  });

  Future<bool> isDarkMode();

  Future<bool> isFirstTime();

  Future<SessionInfo?> getSessionInfo();
}
