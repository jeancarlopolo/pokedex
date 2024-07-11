import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/pokedex_app.dart';
import 'package:pokedex/services/current_tab.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:pokedex/services/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  await setup();
  runApp(const PokedexApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final settings = Settings(prefs);
  settings.init();
  final favorites = Favorites(prefs);
  favorites.init();
  // GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<Favorites>(favorites);
  GetIt.I.registerSingleton<Settings>(settings);
  GetIt.I.registerLazySingleton<PokemonService>(() => PokemonService(),);
  GetIt.I.registerSingleton<CurrentTab>(CurrentTab());
}