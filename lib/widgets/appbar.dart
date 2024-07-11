import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/current_tab.dart';
import 'package:signals/signals_flutter.dart';

import '../services/search_pokemon.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  final currentTab = GetIt.I<CurrentTab>().currentTab;

  final searchService = SearchPokemon();

  @override
  void initState() {
    super.initState();
    searchService.searchController.addPageRequestListener((pageKey) {
      searchService.fetchPokemonsByType(
          searchService.chosenType.value, pageKey);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}
