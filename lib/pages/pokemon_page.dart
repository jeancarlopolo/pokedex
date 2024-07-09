import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  void initState() {
    super.initState();
    pokemonService.pagingController.addPageRequestListener((pageKey) {
      pokemonService.fetchPokemons(pageKey);
    });
  }

  final PokemonService pokemonService = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagedGridView(
        padding: const EdgeInsets.all(16),
        pagingController: pokemonService.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          itemBuilder: (context, pokemon, index) {
            return PokemonCard(pokemon);
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 20
        ),
      ),
    );
  }

  @override
  void dispose() {
    pokemonService.pagingController.dispose();
    super.dispose();
  }
}
