import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/services/settings.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:signals/signals_flutter.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({super.key});

  final favorites = GetIt.I<Favorites>();

  final navigationMode = GetIt.I<Settings>().navbarMode;

  @override
  Widget build(BuildContext context) {
    return favorites.favoritePokemons.watch(context).isEmpty
        ? const Center(
            child: Text("No favorites yet :("),
          )
        : GridView.builder(
            itemBuilder: (context, index) =>
                PokemonCard(favorites.favoritePokemons.watch(context)[index]),
            padding: const EdgeInsets.all(16),
            itemCount: favorites.favoritePokemons.watch(context).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 20,
            ),
          );
  }
}
