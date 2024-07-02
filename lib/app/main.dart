import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/pokedex_app.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setup();
  runApp(const PokedexApp());
}

void setup() async {
  final prefs = await SharedPreferences.getInstance();
  final settings = Settings(prefs);
  settings.init();
  final favorites = Favorites(prefs);
  favorites.init();
  // GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<Settings>(settings);
  GetIt.I.registerSingleton<Favorites>(favorites);
}