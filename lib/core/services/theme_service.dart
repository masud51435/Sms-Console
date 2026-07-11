import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../storage/local_storage.dart';

class ThemeService extends GetxService {
  final LocalStorage _storage;

  ThemeService(this._storage);

  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDarkMode from local storage and if it's empty, return false (light theme)
  bool _loadThemeFromBox() => _storage.read(_key) == 'true';

  /// Save isDarkMode to local storage
  Future<void> _saveThemeToBox(bool isDarkMode) =>
      _storage.write(_key, isDarkMode.toString());

  /// Switch theme and save to local storage
  Future<void> switchTheme() async {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    await _saveThemeToBox(!_loadThemeFromBox());
  }

  bool get isDarkMode => _loadThemeFromBox();
}
