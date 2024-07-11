import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/constants/pokemon_type.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import 'package:pokedex/widgets/type_icon.dart';
import 'package:signals/signals_flutter.dart';
import 'package:http/http.dart' as http;

class SearchPokemon extends SearchDelegate {
  final chosenType = signal<PokemonType?>(null);
  final searchController = PagingController<int, Pokemon>(firstPageKey: 0);

  Future<Pokemon> fetchPokemonByName(String name) async {
    final response = await http.get(Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/${name.toLowerCase().trim()}'));
    final data = json.decode(response.body);
    return Pokemon.fromMap(data);
  }

  Future<void> fetchPokemonsByType(PokemonType? type, int pageKey) async {
    try {
      if (type == null) {
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
          searchController.appendLastPage(pokemons);
        } else {
          final nextPageKey = pageKey + pokemons.length;
          searchController.appendPage(pokemons, nextPageKey);
        }
      } else {
        final response = await http
            .get(Uri.parse('https://pokeapi.co/api/v2/type/${type.name}'));
        final data = json.decode(response.body);
        List<Pokemon> pokemons = [];

        for (Map pokemonMap
            in (data['pokemon'] as List).sublist(pageKey, pageKey + 10)) {
          final pokemonResponse =
              await http.get(Uri.parse(pokemonMap['pokemon']['url']));
          final pokemonData = json.decode(pokemonResponse.body);
          pokemons.add(Pokemon.fromMap(pokemonData));
        }
        if (pokemons.length < 10) {
          searchController.appendLastPage(pokemons);
        } else {
          final nextPageKey = pageKey + 10;
          searchController.appendPage(pokemons, nextPageKey);
        }
      }
    } catch (error) {
      searchController.error = error;
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () async {
            chosenType.value = await showDialog(
              context: context,
              builder: (context) => Dialog(
                alignment: Alignment.center,

                child: Container(
                  width: 400,
                  padding: const EdgeInsets.all(16),
                  child: GridView(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    children: [
                      ...List.generate(
                        18,
                        (index) => GestureDetector(
                          onTap: () {
                            Navigator.pop(context, PokemonType.values[index]);
                          },
                          child: TypeIcon(
                            pokemonType: PokemonType.values[index],
                            height: 35,
                            width: 35,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context, null);
                          },
                          icon: const CloseButtonIcon())
                    ],
                  ),
                ),
              ),
            );
            searchController.refresh();
            query = '';
            if (context.mounted) showResults(context);
          },
          icon: const Icon(Icons.filter_list_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query != ''
        ? Center(
            child: FutureBuilder(
              future: fetchPokemonByName(query),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: const EdgeInsets.all(16),
                    children: [PokemonCard(snapshot.data!)],
                  );
                }
                if (snapshot.hasError) {
                  return const Text('Pokémon not found.');
                }
                return const CircularProgressIndicator();
              },
            ),
          )
        : PagedGridView(
            padding: const EdgeInsets.all(16),
            pagingController: searchController,
            builderDelegate: PagedChildBuilderDelegate<Pokemon>(
              itemBuilder: (context, pokemon, index) {
                return PokemonCard(pokemon);
              },
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 20),
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
