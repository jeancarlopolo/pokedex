import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

enum NavigationMode {
  drawer, navbar
}

class Settings {
  final currentTheme = signal(ThemeMode.light);
  final navigationMode = signal(NavigationMode.drawer);

  // pegar do banco de dados
  bool _loadTheme() => 
  bool _loadNavigationMode() =>

  bool load() {
    bool success = _loadTheme();
    success *= _loadNavigationMode();
    return success;
  }

  void toggleTheme() =>

  void toggleNavigationMode() =>
}