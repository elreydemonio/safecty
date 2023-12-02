import 'package:flutter/material.dart';
import 'package:safecty/model/storage/secure_storage.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel({
    required secureStorage,
  }) : _secureStorage = secureStorage;

  final SecureStorage _secureStorage;

  late bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  ThemeMode getTheme() {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> initialize() async {
    _isDarkMode = await _secureStorage.isDarkMode();
  }

  void updateTheme({required bool darkMode}) async {
    await _secureStorage.changeTheme(
      isDarkMode: isDarkMode,
    );
    notifyListeners();
  }
}
