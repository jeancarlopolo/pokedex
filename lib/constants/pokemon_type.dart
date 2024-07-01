import 'package:flutter/material.dart';

enum PokemonType {
  normal('normal', Color(0xffA0A29F)),
  fire('fire', Color(0xffFBA54C)),
  water('water', Color(0xff539DDF)),
  electric('electric', Color(0xffF2D94E)),
  grass('grass', Color(0xff5FBD58)),
  ice('ice', Color(0xff75D0C1)),
  fighting('fighting', Color(0xffD3425F)),
  poison('poison', Color(0xffB763CF)),
  ground('ground', Color(0xffDA7C4D)),
  flying('flying', Color(0xffA1BBEC)),
  psychic('psychic', Color(0xffFA8581)),
  bug('bug', Color(0xff92BC2C)),
  rock('rock', Color(0xffC9BB8A)),
  ghost('ghost', Color(0xff5F6DBC)),
  dragon('dragon', Color(0xff0C69C8)),
  dark('dark', Color(0xff595761)),
  steel('steel', Color(0xff5695A3)),
  fairy('fairy', Color(0xffEE90E6));

  final String name;
  final Color color;
  const PokemonType(this.name, this.color);

  String get svgPath => 'assets/icons/$name.svg';

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
