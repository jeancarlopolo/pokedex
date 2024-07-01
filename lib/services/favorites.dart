import 'package:signals/signals.dart';

class Favorites {
  final favoriteIds = listSignal<int>([]);

  void add(int id) => favoriteIds.add(id);
  void remove(int id) => favoriteIds.remove(id);

  void loadFavorites() {}

  List<Pokemon> get pokemons {
    // TODO: pegar da API
  }
}