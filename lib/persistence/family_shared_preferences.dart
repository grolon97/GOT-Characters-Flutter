import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FamilySharedPreferences {
  SharedPreferences? _prefs;

  FamilySharedPreferences() {
    _init();
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  void setFavouriteFamilies(List<int> familiesList) async {
    await _prefs!.setString('favouriteFamilies', jsonEncode(familiesList));
  }

  List<int> getFavouriteFamilies() {
    String? result = _prefs?.getString('favouriteFamilies');
    if (result != null) {
      return List.from(jsonDecode(result));
    }

    return [];
  }


}
