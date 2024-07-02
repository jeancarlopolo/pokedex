import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/constants/pokemon_type.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:signals/signals.dart';

class PokemonService {
  final List<Pokemon> _pokemons = [];
  int _page = 0;
  final _isLoading = signal(false);

  List<Pokemon> get pokemons => _pokemons;
  Signal<bool> get isLoading => _isLoading;

  void clear() {
    _page = 0;
    _pokemons.clear();
  }

  Future<void> fetchPokemons() async {
    if (_isLoading.value) return;

    _isLoading.value = true;
    print('https://pokeapi.co/api/v2/pokemon?offset=${_page * 20}&limit=20');
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=${_page * 20}&limit=20'));
    final data = json.decode(response.body);

    for (Map pokemon in data['results'] as List) {
      final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
      final pokemonData = json.decode(pokemonResponse.body);
      print(pokemonData['name']);
      _pokemons.add(Pokemon.fromMap(pokemonData));
    }

    _page++;

    _isLoading.value = false;
  }

  Future<void> fetchPokemonsByType(PokemonType type) async {
    if (_isLoading.value) return;

    _isLoading.value = true;
    clear();

    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/type/${type.name}'));
    final data = json.decode(response.body);

    for (Map pokemonMap in data['pokemon'] as List) {
      final pokemonResponse =
          await http.get(Uri.parse(pokemonMap['pokemon']['url']));
      final pokemonData = json.decode(pokemonResponse.body);
      _pokemons.add(Pokemon.fromMap(pokemonData));
    }
    _page++;

    _isLoading.value = false;
  }

  Future<void> fetchPokemonsByName(String name) async {
    if (_isLoading.value) return;

    _isLoading.value = true;

    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=10000'));
    final data = json.decode(response.body);

    for (Map pokemon in data['results'] as List) {
      if ((pokemon['name'] as String)
          .toLowerCase()
          .contains(name.toLowerCase().trim())) {
        final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
        final pokemonData = json.decode(pokemonResponse.body);
        _pokemons.add(Pokemon.fromMap(pokemonData));
      }
    }

    _page++;

    _isLoading.value = false;
  }
}
