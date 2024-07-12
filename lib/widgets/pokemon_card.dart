import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/favorites.dart';
import 'package:pokedex/widgets/type_icon.dart';
import 'package:signals/signals_flutter.dart';

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
    return GestureDetector(
      onTap: () => GetIt.I<Favorites>().toggleFavorite(pokemon),
      child: GridTile(
        header: Center(
          child: GridTileBar(
            trailing: GetIt.I<Favorites>()
                    .favoriteIds
                    .watch(context)
                    .contains(pokemon.id)
                ? const Icon(
                    Icons.favorite_rounded,
                    color: Colors.redAccent,
                  )
                : const Icon(
                    Icons.favorite_border_rounded,
                  ),
            title: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).secondaryHeaderColor.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        '${pokemon.id.padLeft(3, '0')} - ${pokemon.name}',
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
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
              BoxShadow(color: pokemon.pokemonTypes[0].color, spreadRadius: 3)
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: CachedNetworkImage(
            imageUrl: pokemon.sprite,
            height: 110,
            fit: BoxFit.contain,
            maxHeightDiskCache: 175,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
