import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/constants/pokemon_type.dart';


class Pokemon {
  int id;
  String name;
  List<PokemonType> pokemonTypes = [];
  Image image;
  Pokemon({
    required this.id,
    required this.name,
    required this.pokemonTypes,
    required this.image,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    List<PokemonType>? pokemonTypes,
    Image? image,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      pokemonTypes: pokemonTypes ?? this.pokemonTypes,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'pokemonTypes': pokemonTypes.map((x) => x.name).toList(),
      'image': image.toMap(),
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int,
      name: map['name'] as String,
      pokemonTypes: (map['types'] as List<String>).map((typeName) => PokemonType.fromString(typeName)!).toList()
      image: Image.fromMap(map['image'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) => Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, pokemonTypes: $pokemonTypes, image: $image)';
  }

  @override
  bool operator ==(covariant Pokemon other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      listEquals(other.pokemonTypes, pokemonTypes) &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      pokemonTypes.hashCode ^
      image.hashCode;
  }
}
