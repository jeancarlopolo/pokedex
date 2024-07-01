import 'dart:convert';

import 'package:pokedex/models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';
import 'package:http/http.dart' as http;

class Favorites {
  Favorites(SharedPreferences prefs) {
    _prefs = prefs;
    final loadedValues = prefs.getStringList('favorites');
    if (loadedValues != null) {
      favoriteIds.value = loadedValues.map((e) => int.parse(e)).toList();
    } else {
      prefs.setStringList('favorites', []);
    }
  }

  late final SharedPreferences _prefs;

  final favoriteIds = listSignal<int>([]);

  void add(int id) {
    favoriteIds.add(id);

    final favoriteIdsString = favoriteIds.value.map((e) => '$e').toList();
    _prefs.setStringList('favorites', favoriteIdsString);
  }

  void remove(int id) {
    favoriteIds.remove(id);

    final favoriteIdsString = favoriteIds.value.map((e) => '$e').toList();
    _prefs.setStringList('favorites', favoriteIdsString);
  }

  Future<List<Pokemon>> get pokemons async {
    final List<Pokemon> lista = [];
    for (int id in favoriteIds.value) {
      final response =
          await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$id'));
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final Pokemon pokemon = Pokemon.fromJson(json);
        lista.add(pokemon);
      } else {
        throw Exception('Failed to load favorite Pokémon');
      }
    }
    return lista;
  }
}
