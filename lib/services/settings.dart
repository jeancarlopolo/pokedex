import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

enum NavigationMode { drawer, navbar }

class Settings {
  Settings(SharedPreferences prefs) {
    _prefs = prefs;
  }

  late final SharedPreferences _prefs;

  void init() async {
    final loadedTheme = _prefs.getString('theme');
    if (loadedTheme != null) {
      currentTheme.value =
          loadedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    } else {
      _prefs.setString('theme', 'light');
    }

    final loadedNavigationMode = _prefs.getString('navigation');
    if (loadedNavigationMode != null) {
      currentNavigationMode.value = loadedNavigationMode == 'navbar'
          ? NavigationMode.navbar
          : NavigationMode.drawer;
    } else {
      _prefs.setString('navigation', 'drawer');
    }
  }

  final currentTheme = signal<ThemeMode>(ThemeMode.light);
  final currentNavigationMode = signal<NavigationMode>(NavigationMode.drawer);

  void toggleTheme() {
    if (currentTheme.value == ThemeMode.light) {
      currentTheme.value == ThemeMode.dark;
      _prefs.setString('theme', 'dark');
    } else {
      currentTheme.value == ThemeMode.light;
      _prefs.setString('theme', 'light');
    }
  }

  void toggleNavigationMode() {
    if (currentNavigationMode.value == NavigationMode.drawer) {
      currentNavigationMode.value == NavigationMode.navbar;
      _prefs.setString('navigation', 'navbar');
    } else {
      currentNavigationMode.value == NavigationMode.drawer;
      _prefs.setString('navigation', 'drawer');
    }
  }
}
