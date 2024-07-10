import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

class Favorites {
  Favorites(SharedPreferences prefs) {
    _prefs = prefs;
  }

  late final SharedPreferences _prefs;

  // salva apenas os ids no celular pra pegar da api quando o app abre
  final favoriteIds = listSignal<String>([]);
  final favoritePokemons = listSignal<Pokemon>([]);
  final pagingController = PagingController(firstPageKey: 0);

  void init() async {
    final loadedValues = _prefs.getStringList('favorites');
    if (loadedValues != null) {
      favoriteIds.value = loadedValues;
      fetchPokemons();
    } else {
      favoriteIds.value = [];
      _prefs.setStringList('favorites', []);
    }
  }

  void toggleFavorite(Pokemon pokemon) {
    if (favoriteIds.contains(pokemon.id)) {
      _remove(pokemon);
    } else {
      _add(pokemon);
    }
  }

  void _add(Pokemon pokemon) {
    favoriteIds.add(pokemon.id);
    favoritePokemons.add(pokemon);
    favoritePokemons.sort(
      (a, b) => int.parse(a.id).compareTo(int.parse(b.id)),
    );

    _prefs.setStringList('favorites', favoriteIds);
  }

  void _remove(Pokemon pokemon) {
    favoriteIds.remove(pokemon.id);
    favoritePokemons.remove(pokemon);

    _prefs.setStringList('favorites', favoriteIds);
  }

  void fetchPokemons() async {
    for (String id in favoriteIds) {
      bool found = false;
      for (Pokemon pokemon in favoritePokemons) {
        found = false;
        if (pokemon.id == id) {
          found = true;
          break;
        }
      }
      if (found == false) {
        // se não carregou ainda nos pokemons em cache
        favoritePokemons.add(await Pokemon.fromId(id));
      }
    }
  }
}
