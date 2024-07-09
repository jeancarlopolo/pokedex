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
    return GridTile(
      header: Center(
        child: GridTileBar(
          title: Center(
            child: Container(
              decoration: BoxDecoration(color: Theme.of(context).secondaryHeaderColor, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(2),
              child: Text(
                '${pokemon.id.padLeft(3, '0')} - ${pokemon.name[0].toUpperCase()}${pokemon.name.substring(1)}',
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
          ),
        ),
      ),
      footer: GridTileBar(
        title: Row(
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
        alignment: Alignment.center,
        child: Image.network(
          pokemon.sprite,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
