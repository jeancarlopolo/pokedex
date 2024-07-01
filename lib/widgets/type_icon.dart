import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/constants/pokemon_type.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon({super.key, required this.pokemonType});

  final PokemonType pokemonType;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: , child: SvgPicture.asset(pokemonType.svgPath),);
  }
}
