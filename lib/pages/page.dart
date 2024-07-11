import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemon_page.dart';
import 'package:pokedex/pages/settings_page.dart';
import 'package:pokedex/services/current_tab.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/search_pokemon.dart';
import 'package:pokedex/services/settings.dart';
import 'package:pokedex/widgets/drawer.dart';
import 'package:pokedex/widgets/navbar.dart';
import 'package:signals/signals_flutter.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});
  static final Map<int, Widget> tabs = {
    0: const PokemonPage(),
    1: FavoritesPage(),
    2: SettingsPage(),
  };

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final favorites = GetIt.I<Favorites>();

  final navigationMode = GetIt.I<Settings>().navbarMode;

  final currentTab = GetIt.I<CurrentTab>().currentTab;


  final searchService = SearchPokemon();

  @override
  void initState() {
    super.initState();
    searchService.searchController.addPageRequestListener((pageKey) {
      searchService.fetchPokemonsByType(
          searchService.chosenType.value, pageKey);
    });
    effect(() {
      searchService.chosenType;
      searchService.searchController.refresh();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      actions: currentTab.watch(context) == 0
          ? [
              IconButton(
                onPressed: () => showSearch(
                  context: context,
                  delegate: searchService,
                ),
                icon: const Icon(Icons.search),
              )
            ]
          : null,
    ),
      drawer: !navigationMode.watch(context) ? MyDrawer() : null,
      bottomNavigationBar: navigationMode.watch(context) ? MyNavBar() : null,
      body: SafeArea(child: MyPage.tabs[currentTab.watch(context)]!),
    );
  }
}
