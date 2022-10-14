import 'dart:convert';

import '../models/family.dart';
import '../services/api_service.dart';
import '../services/firebase_service.dart';

class FamilyRepository {
  final ApiService _apiService = ApiService();
  final FirebaseService _firebaseService = FirebaseService();

  Future<List<Family>> getFamiliesList() async {
    final response = await _apiService.getAllFamilies();

    final familiesId = await _apiService.getCharactersFamilyId();
    List<dynamic> decodedJson = json.decode(familiesId.body);

    List<int> idsList =
        List<int>.from(decodedJson.map((item) => item["family_id"]));

    // find amount of characters per each family
    Map ocurrencesMap = <int, int>{};
    for (var x in idsList) {
      ocurrencesMap[x] =
          ocurrencesMap.containsKey(x) ? ocurrencesMap[x]! + 1 : 1;
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

  Future<Family> getFamiliesyId(int id) async {
    final response = await _apiService.getFamilyById(id);
    return Family.fromJson(json.decode(response.body));
  }

  Future<List<Family>> getFavouriteFamilies() async {
    final response = await _firebaseService.getFavouriteFamilies();
    final firebaseData = Map<String, dynamic>.from(response as dynamic);
    List<Family> list = [];
    firebaseData.forEach((key, value) {
      var jsonData = json.decode(json.encode(value));
      list.add(Family.fromJson(jsonData));
    });
    return list;
  }

  Future<void> addFavouriteFamily(Family family) async {
    await _firebaseService.addFavFamily(family);
  }

  Future<void> removeFavouriteFamily(Family family) async {
    await _firebaseService.removeFavFamily(family);
  }
}
