import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/my_app.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/settings.dart';

void main() {
  setup();
  runApp(const MyApp());
}

void setup() async {
  final prefs = await SharedPreferences.getInstance();
  // GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<Settings>(Settings(prefs));
  GetIt.I.registerSingleton<Favorites>(Favorites(prefs));
}