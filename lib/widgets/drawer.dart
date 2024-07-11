import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/current_tab.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});
  final currentTab = GetIt.I<CurrentTab>().currentTab;
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pop(context);
                currentTab.value = 0;
              },
              title: const Text('Pokémon'),
              leading: const Icon(Icons.grid_view_rounded),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                currentTab.value = 1;
              },
              title: const Text('Favorites'),
              leading: const Icon(Icons.favorite_border_rounded),
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                currentTab.value = 2;
              },
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
