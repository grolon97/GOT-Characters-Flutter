import '../models/family.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import 'dart:convert';

class FamilyRepository {
  final ApiService _apiService = ApiService();

  Future<List<Family>> getHousesList() async {
    final response = await _apiService.getAllFamilies();

    final familiesId = await _apiService.getCharactersFamilyId();
    List<dynamic> decodedJson = json.decode(familiesId.body);

    List<int> idsList = List<int>.from(decodedJson.map( (item) => item["family_id"]));

    // find amount of characters per each family
    Map ocurrencesMap = <int, int>{};
    for (var x in idsList) {
      ocurrencesMap[x] = ocurrencesMap.containsKey(x) ? ocurrencesMap[x]! + 1 : 1;
    }

    List<Family> familiesList = [];

    // create the family list from response body
    json.decode(response.body).forEach((f) {
      Family newFamily = Family.fromJson(f);
      newFamily.characterCount = ocurrencesMap[newFamily.id];
      familiesList.add(newFamily);
    });
    return familiesList;
  }

  Future<Family> getHouseById(int id) async {
    final response = await _apiService.getFamilyById(id);
    return Family.fromJson(json.decode(response.body));
  }
  
}