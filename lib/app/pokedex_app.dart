import 'package:flutter/material.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';
import 'package:pokedex/pages/settings_page.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Pókedex',
      initialRoute: '/pokemon',
      // TODO telas
      routes: {
        '/pokemon': (context) => const PokemonPage(),
        '/favorites': (context) => const FavoritesPage(),
        '/settings': (context) => const SettingsPage()
      },
    );
  }
}
