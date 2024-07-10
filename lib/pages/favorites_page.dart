import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/widgets/drawer.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:signals/signals_flutter.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final favorites = GetIt.I<Favorites>();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    favorites.favoritePokemons.sort((a, b) => a.id.compareTo(b.id),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // pesqiusa e filtro TODO

      drawer: const MyDrawer(),
      body: GridView.builder(
        itemBuilder: (context, index) =>
            PokemonCard(favorites.favoritePokemons.watch(context)[index]),
        padding: const EdgeInsets.all(16),
        itemCount: favorites.favoritePokemons.watch(context).length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
