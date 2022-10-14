import 'package:http/http.dart' as http;


class ApiService {

  static const String _baseUrl = "http://myipaddress:3000";
  static const Duration defaultTimeout = Duration(seconds: 10);


  Future<dynamic> getAllCharacters() async {
    // should be inside a try/catch block in case errors occurs when reaching the API
    http.Response response = await http.get(Uri.parse('$_baseUrl/characters')).timeout(defaultTimeout);
    return response;
  } 

  Future<dynamic> getCharacterById(int id) async {
      return await http.get(Uri.parse('$_baseUrl/characters?id=eq.$id')).timeout(defaultTimeout);
  }
  
  Future<dynamic> getCharactersFamilyId() async {
    return await http.get(Uri.parse('$_baseUrl/characters?select=family_id')).timeout(defaultTimeout);
  }

  Future<dynamic> getAllFamilies() async { 
    return await http.get(Uri.parse('$_baseUrl/families')).timeout(defaultTimeout);
  }

  Future<dynamic> getFamilyById(int id) async {
    return await http.get(Uri.parse('$_baseUrl/families?id=eq.$id')).timeout(defaultTimeout);
  }

  Future<dynamic> getCharactersByFamilyId(int familyId) async {
    return await http.get(Uri.parse('$_baseUrl/characters?family_id=eq.$familyId')).timeout(defaultTimeout);
  }


}