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
      favoritePokemons.value = await _loadPokemons();
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
    favoritePokemons.add(await Pokemon.fromId(id));

    _prefs.setStringList('favorites', _favoriteIds);
  }

  void _remove(String id) {
    _favoriteIds.remove(id);
    favoritePokemons.removeWhere(
      (element) => element.id == id,
    );

    _prefs.setStringList('favorites', _favoriteIds);
  }

  Future<List<Pokemon>> _loadPokemons() async {
    final List<Pokemon> lista = [];
    for (String id in _favoriteIds) {
      lista.add(await Pokemon.fromId(id));
    }
    return lista;
  }
}
