import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/constants/pokemon_type.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon({super.key, required this.pokemonType, this.height = 100, this.width = 100});

  final PokemonType pokemonType;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: pokemonType.color),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(25),

      child: SvgPicture.asset(
        pokemonType.svgPath,
        alignment: Alignment.center,
        height: height,
        width: width,
      ),
    );
  }
}
