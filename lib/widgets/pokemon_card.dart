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
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          child: Image.network(
            pokemon.sprite,
            alignment: Alignment.center,
            fit: BoxFit.scaleDown,
            height: 100,
            width: 100,
          ),
        ),

//TODO tema
        Text(pokemon.name),
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TypeIcon(
                pokemonType: pokemon.pokemonTypes[0],
                height: 50,
                width: 50,
              ),
              pokemon.pokemonTypes.length > 1
                  ? TypeIcon(
                      pokemonType: pokemon.pokemonTypes[1],
                      height: 50,
                      width: 50,
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }
}
