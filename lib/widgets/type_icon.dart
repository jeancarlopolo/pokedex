import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex/constants/pokemon_type.dart';

class TypeIcon extends StatelessWidget {
  const TypeIcon(
      {super.key,
      required this.pokemonType,
      this.height = 100,
      this.width = 100});

  final PokemonType pokemonType;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: pokemonType.color,
          boxShadow: const [BoxShadow(spreadRadius: 0, blurRadius: 1)]),
      padding: EdgeInsets.all(height / 4),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: SvgPicture.asset(
        pokemonType.svgPath,
        alignment: Alignment.center,
        fit: BoxFit.scaleDown,
        height: height,
        width: width,
      ),
    );
  }
}
