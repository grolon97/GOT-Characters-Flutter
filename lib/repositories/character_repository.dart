// this class will make API calls and convert json to dart models
import 'package:http/http.dart';

import '../models/character.dart';
import '../models/family.dart';
import '../repositories/family_repository.dart';
import '../services/api_service.dart';
import 'dart:convert';

class CharacterRepository {
  final ApiService _apiService = ApiService();

  // could reutilize this method with optional param
  Future<List<Character>> getCharactersList({int? familyId}) async {
    Response response;
    if (familyId != null) {
      response = await _apiService.getCharactersByFamilyId(familyId);
    } else {
      response = await _apiService.getAllCharacters();
    }
    var familyRepository = FamilyRepository();
    List<Family> allFamilies = await familyRepository.getHousesList();
    List<dynamic> decodedJson = json.decode(response.body);
    List<Character> characterList = decodedJson.map((c) => Character.fromJson(c)).toList();
    
    for (Character c in characterList) {
      // will look for characters family id
      for (Family f in allFamilies) {
        if (c.familyId == f.id) {
          c.familyName = f.name;
        }
      }
    }

    return characterList;

  }

  Future<Character> getCharacterById(int id) async {
    final response = await _apiService.getCharacterById(id);
    return Character.fromJson(json.decode(response.body));
  }

}