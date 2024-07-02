import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:pokedex/constants/pokemon_type.dart';

class Pokemon {
  String id;
  String name;
  List<PokemonType> pokemonTypes = [];
  String sprite;

  Pokemon({
    required this.id,
    required this.name,
    required this.pokemonTypes,
    required this.sprite,
  });

  Pokemon copyWith({
    String? id,
    String? name,
    List<PokemonType>? pokemonTypes,
    String? sprite,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      pokemonTypes: pokemonTypes ?? this.pokemonTypes,
      sprite: sprite ?? this.sprite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pokemonTypes': pokemonTypes.map((x) => x.name).toList(),
      'sprite': sprite,
    };
  }

  static Future<Pokemon> fromId(String id) async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Pokemon.fromJson(json);
    } else {
      throw Exception('Failed to load Pokémon');
    }
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'id': String id,
        'name': String name,
        'types': List types,
        'sprite': {'front_default': String sprite}
      } =>
        Pokemon(
            id: id,
            name: name,
            pokemonTypes: types
                .map((type) => PokemonType.fromString(type['name'])!)
                .toList(),
            sprite: sprite),
      _ => throw const FormatException('Failed to load Pokémon.'),
    };
    //pokemonTypes: (map['types'] as List).map((type) => PokemonType.fromString(type['name'])!).toList(),
    //sprite: map['sprites']['front_default']
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, pokemonTypes: $pokemonTypes, sprite: $sprite)';
  }

  @override
  bool operator ==(covariant Pokemon other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.pokemonTypes, pokemonTypes) &&
        other.sprite == sprite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        pokemonTypes.hashCode ^
        sprite.hashCode;
  }
}
