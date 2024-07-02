import 'package:flutter/material.dart';
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
    return Column(
      children: [
        Stack(
          children: [
            // icones dos tipos
            Align(
              alignment: Alignment.bottomLeft,
              child: TypeIcon(pokemonType: pokemon.pokemonTypes[0]),
            ),

            pokemon.pokemonTypes.length > 1
                ? Align(
                    alignment: Alignment.topRight,
                    child: TypeIcon(pokemonType: pokemon.pokemonTypes[1]),
                  )
                : const SizedBox(),

            Container(
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(15),
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              height: 300,
              width: 300,
              child: Image.network(
                pokemon.sprite,
                alignment: Alignment.center,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),

//TODO tema
        Text(pokemon.name)
      ],
    );
  }
}
