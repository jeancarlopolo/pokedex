import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/constants/themes.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';
import 'package:pokedex/pages/settings_page.dart';
import 'package:pokedex/services/settings.dart';
import 'package:signals/signals_flutter.dart';

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});
  late final currentTheme = GetIt.I<Settings>().currentTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pókedex',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: currentTheme.watch(context),
      initialRoute: '/pokemon',
      routes: {
        '/pokemon': (context) => const PokemonPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}
