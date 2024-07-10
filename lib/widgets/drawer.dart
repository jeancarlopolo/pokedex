import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.restorablePushReplacementNamed(context, '/pokemon'),
            title: const Text('Pokémon'),
            leading: const Icon(Icons.grid_view_rounded),
          ),
          ListTile(
            onTap: () => Navigator.restorablePushReplacementNamed(context, '/favorites'),
            title: const Text('Favorites'),
            leading: const Icon(Icons.favorite_border_rounded),
          ),
          ListTile(
            onTap: () => Navigator.restorablePushReplacementNamed(context, '/settings'),
            title: const Text('Settings'),
            leading: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
