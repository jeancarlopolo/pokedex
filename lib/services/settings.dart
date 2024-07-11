import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

enum NavigationMode { drawer, navbar }

class Settings {
  Settings(SharedPreferences prefs) {
    _prefs = prefs;
  }

  late final SharedPreferences _prefs;

  void init() async {
    bool? loadedTheme = false;
    bool? loadedNavigationMode = false;
    try {
      loadedTheme = _prefs.getBool('theme');
    } catch (e) {
      _prefs.remove('theme');
      loadedTheme = null;
    }
    if (loadedTheme != null) {
      darkMode.value = loadedTheme;
    } else {
      _prefs.setBool('theme', false);
    }

    try {
      loadedNavigationMode = _prefs.getBool('navigation');
    } catch (e) {
      _prefs.remove('navigation');
      loadedNavigationMode = null;
    }
    if (loadedNavigationMode != null) {
      navbarMode.value = loadedNavigationMode ;
    } else {
      _prefs.setBool('navigation', false);
    }
  }

  final darkMode = signal<bool>(false);
  final navbarMode = signal<bool>(false);

  void toggleTheme(bool dark) {
    darkMode.value = dark;
    _prefs.setBool('theme', dark);
  }

  void toggleNavigationMode(bool navbar) {
    navbarMode.value = navbar;
    _prefs.setBool('navigation', navbar);
  }
}
