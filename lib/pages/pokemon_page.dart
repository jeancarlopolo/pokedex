import 'package:flutter/material.dart';
import 'package:pokedex/services/pokemon_service.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:signals/signals_flutter.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  @override
  void initState() {
    super.initState();
    pokemonService.fetchPokemons();
  }

  final PokemonService pokemonService = PokemonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pokemonService.isLoading.watch(context)
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                if (index == pokemonService.pokemons.length - 1) {
                  pokemonService.fetchPokemons();
                }
                return PokemonCard(
                  pokemonService.pokemons[index],
                );
              },
              itemCount: pokemonService.pokemons.length,
            ),
    );
  }
}
