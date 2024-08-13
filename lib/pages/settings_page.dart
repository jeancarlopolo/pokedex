import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/settings.dart';
import 'package:signals/signals_flutter.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final settings = GetIt.I<Settings>();
  final favorites = GetIt.I<Favorites>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile.adaptive(
          value: settings.darkMode.watch(context),
          onChanged: (value) => settings.toggleTheme(value),
          title: const Text('Modo escuro'),
          thumbIcon: const WidgetStatePropertyAll(Icon(Icons.brush_rounded)),
        ),
        SwitchListTile.adaptive(
          value: settings.navbarMode.watch(context),
          onChanged: (value) => settings.toggleNavigationMode(value),
          title: const Text('Modo de navegação alternativo'),
          thumbIcon:
              const WidgetStatePropertyAll(Icon(Icons.navigation_rounded)),
        ),
        ListTile(
          onTap: () => favorites.clear(),
          title: const Text('Limpar favoritos'),
          leading: const Icon(Icons.delete_forever_rounded),
        ),
      ],
    );
  }
}
