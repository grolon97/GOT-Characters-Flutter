import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterSharedPreferences {
  SharedPreferences? _prefs;

  CharacterSharedPreferences() {
    _init();
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /* preguntar a Leo si solamente se mantiene la configuración o
     se debe almacenar toda la información para que la aplicación funcione de manera offline */
  void setFavouritesList(List<int> charactersList) async {
    await _prefs!.setString('favourites', jsonEncode(charactersList));
  }

  List<int> getFavouritesList() {
    String? result = _prefs?.getString('favourites');
    if (result != null) {
      // cast '[2, 4, 6, 10, 23]' to List<int>
      return List.from(jsonDecode(result));
    }

    return [];
  }
}
