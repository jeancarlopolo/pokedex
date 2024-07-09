import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/type_icon.dart';

List<Color> _generateGradientColorsFromPokemon(Pokemon pokemon) {
  if (pokemon.pokemonTypes.length == 2) {
    return [
      pokemon.pokemonTypes[0].color,
      pokemon.pokemonTypes[1].color,
    ];
  }
  return [
    pokemon.pokemonTypes[0].color,
    pokemon.pokemonTypes[0].color,
  ];
}

class PokemonCard extends StatelessWidget {
  PokemonCard(this.pokemon, {super.key});

  final Pokemon pokemon;

  late final gradient = LinearGradient(
      colors: _generateGradientColorsFromPokemon(pokemon),
      stops: const [0, 1],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TypeIcon(
            pokemonType: pokemon.pokemonTypes[0],
            height: 25,
            width: 25,
          ),
          pokemon.pokemonTypes.length > 1
              ? TypeIcon(
                  pokemonType: pokemon.pokemonTypes[1],
                  height: 25,
                  width: 25,
                )
              : const SizedBox(),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          boxShadow: [
            BoxShadow(
                color: pokemon.pokemonTypes[0].color,
                blurRadius: 3,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        alignment: Alignment.topCenter,
        child: Image.network(
          pokemon.sprite,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
