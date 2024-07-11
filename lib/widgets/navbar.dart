import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/current_tab.dart';
import 'package:signals/signals_flutter.dart';

class MyNavBar extends StatelessWidget {
  MyNavBar({super.key});

  final currentTab = GetIt.I<CurrentTab>().currentTab;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Pokémon',
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_border_rounded),
          label: 'Favorites',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      onDestinationSelected: (tab) {
        currentTab.value = tab;
      },
      selectedIndex: currentTab.watch(context),
    );
  }
}
