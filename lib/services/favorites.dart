import 'package:pokedex/models/pokemon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signals/signals.dart';

class Favorites {
  Favorites(SharedPreferences prefs) {
    _prefs = prefs;
  }

  late final SharedPreferences _prefs;

  // salva apenas os ids no celular pra pegar da api quando o app abre
  late final List<String> _favoriteIds;
  final favoritePokemons = listSignal<Pokemon>([]);

  void init() async {
    final loadedValues = _prefs.getStringList('favorites');
    if (loadedValues != null) {
      _favoriteIds = loadedValues;
      fetchPokemons();
    } else {
      _favoriteIds = [];
      _prefs.setStringList('favorites', []);
    }
  }

  void toggleFavorite(String id) {
    if (_favoriteIds.contains(id)) {
      _remove(id);
    } else {
      _add(id);
    }
  }

  void _add(String id) async {
    _favoriteIds.add(id);
    _prefs.setStringList('favorites', _favoriteIds);
  }

  void _remove(String id) {
    _favoriteIds.remove(id);
    favoritePokemons.removeWhere(
      (element) => element.id == id,
    );

    _prefs.setStringList('favorites', _favoriteIds);
  }

  void fetchPokemons() async {
    for (String id in _favoriteIds) {
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
