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

  void toggleFavorite(String id) {
    if (favoriteIds.contains(id)) {
      _remove(id);
    } else {
      _add(id);
    }
  }

  void _add(String id) async {
    favoriteIds.add(id);
    _prefs.setStringList('favorites', favoriteIds);
  }

  void _remove(String id) {
    favoriteIds.remove(id);
    favoritePokemons.removeWhere(
      (element) => element.id == id,
    );

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
      if (found == false) { // se não carregou ainda nos pokemons em cache
        favoritePokemons.add(await Pokemon.fromId(id));
      }
    }
  }
}
