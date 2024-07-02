import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon.dart';
import 'package:signals/signals.dart';

class PokemonService {
  final List<Pokemon> _pokemons = [];
  int _page = 0;
  final _isLoading = signal(false);

  List<Pokemon> get pokemons => _pokemons;
  Signal<bool> get isLoading => _isLoading;

  Future<void> fetchPokemons() async {
    if (_isLoading.value) return;

    _isLoading.value = true;

    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon?offset=${_page * 20}&limit=20'));
    final data = json.decode(response.body);

    _pokemons.addAll((data['results'] as List)
        .map((json) => Pokemon.fromJson(json))
        .toList());
    _page++;

    _isLoading.value = false;
  }
}
