import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonService {
  final pagingController = PagingController<int, Pokemon>(firstPageKey: 0);

  Future<void> fetchPokemons(int pageKey) async {
    try {
      // pegando os links dos pokemons
      final response = await http.get(Uri.parse(
          'https://pokeapi.co/api/v2/pokemon?offset=$pageKey&limit=10'));
      final data = json.decode(response.body);
      List<Pokemon> pokemons = [];

      // pegando as informaçoes dos links
      for (Map pokemon in data['results'] as List) {
        final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
        final pokemonData = json.decode(pokemonResponse.body);
        pokemons.add(Pokemon.fromMap(pokemonData));
      }

      // adicionando aos elementos da page
      if (pokemons.length < 10) {
        pagingController.appendLastPage(pokemons);
      } else {
        final nextPageKey = pageKey + pokemons.length;
        pagingController.appendPage(pokemons, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  
}
