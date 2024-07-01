import 'package:flutter/material.dart';

enum PokemonType {
  normal('normal'),
  fire('fire'),
  water('water'),
  electric('electric'),
  grass('grass'),
  ice('ice'),
  fighting('fighting'),
  poison('poison'),
  ground('ground'),
  flying('flying'),
  psychic('psychic'),
  bug('bug'),
  rock('rock'),
  ghost('ghost'),
  dragon('dragon'),
  dark('dark'),
  steel('steel'),
  fairy('fairy');

  final String name;
  final String iconPath;
  const PokemonType(this.name, this.iconPath);

  static PokemonType? fromString(String typeName) {
    for (var type in PokemonType.values) {
      if (type.name == typeName) {
        return type;
      }
    }
    return null;
  }

  static PokemonType? fromMap(Map map) {
    if (map case {'type': String typeName}) {
      return fromString(typeName);
    }
    return null;
  }
}
