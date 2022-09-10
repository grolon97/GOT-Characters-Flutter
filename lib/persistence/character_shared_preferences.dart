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


  void setFavouriteCharacters(List<int> charactersList) async {
    await _prefs!.setString('favouriteCharacters', jsonEncode(charactersList));
  }

  List<int> getFavouriteCharacters() {
    String? result = _prefs?.getString('favouriteCharacters');
    if (result != null) {
      return List.from(jsonDecode(result));
    }

    return [];
  }


}
