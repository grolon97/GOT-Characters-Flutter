// this class will make API calls and convert json to dart models
import '../models/character.dart';
import '../services/api_service.dart';
import 'dart:convert';

class CharacterRepository {
  final ApiService _apiService = ApiService();

  // could reutilize this method with optional param
  Future<List<Character>> getCharactersList({int? familyId}) async {
    var response;
    if (familyId != null) {
      response = await _apiService.getCharactersByFamilyId(familyId);
    } else {
      response = await _apiService.getAllCharacters();
    }
    return _getCharactersListFromJson(response.body);

  }

  Future<Character> getCharacterById(int id) async {
    final response = await _apiService.getCharacterById(id);
    return Character.fromJson(json.decode(response.body));
  }

  List<Character> _getCharactersListFromJson(String jsonString) {
    List<dynamic> decodedJson = json.decode(jsonString);
    return decodedJson.map((c) => Character.fromJson(c)).toList();
  }

}