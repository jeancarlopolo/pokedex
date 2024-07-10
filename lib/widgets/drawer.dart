import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              onTap: () => Navigator.pushReplacementNamed(context, '/pokemon'),
              title: const Text('Pokémon'),
              leading: const Icon(Icons.grid_view_rounded),
            ),
            ListTile(
              onTap: () => Navigator.pushReplacementNamed(context, '/favorites'),
              title: const Text('Favorites'),
              leading: const Icon(Icons.favorite_border_rounded),
            ),
            ListTile(
              onTap: () => Navigator.pushReplacementNamed(context, '/settings'),
              title: const Text('Settings'),
              leading: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}
