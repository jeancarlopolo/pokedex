import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';
import 'package:pokedex/pages/settings_page.dart';
import 'package:pokedex/services/current_tab.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/settings.dart';
import 'package:pokedex/widgets/drawer.dart';
import 'package:pokedex/widgets/navbar.dart';
import 'package:signals/signals_flutter.dart';

class MyPage extends StatelessWidget {
  MyPage({super.key});
  final favorites = GetIt.I<Favorites>();
  final navigationMode = GetIt.I<Settings>().navbarMode;
  final currentTab = GetIt.I<CurrentTab>().currentTab;

  static final Map<int, Widget> tabs = {
    0: const PokemonPage(),
    1: FavoritesPage(),
    2: SettingsPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !navigationMode.watch(context) ? AppBar() : null,
      drawer: !navigationMode.watch(context) ? MyDrawer() : null,
      bottomNavigationBar: navigationMode.watch(context) ? MyNavBar() : null,
      body: SafeArea(child: tabs[currentTab.watch(context)]!),
    );
  }
}
