import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

/*
 This class will only have the responsability to send and recieve
 request from the external api
*/

class ApiService {

  static const String _baseUrl = "http://192.168.1.12:3000";
  static const Duration defaultTimeout = Duration(seconds: 10);

  // generic get method
  Future<dynamic> getAllCharacters() async {
    // should be inside a try/catch block in case errors occurs when reaching the API
    http.Response response = await http.get(Uri.parse('$_baseUrl/characters')).timeout(defaultTimeout);
    return response;
  } 

  Future<dynamic> getCharacterById(int id) async {
      return await http.get(Uri.parse('$_baseUrl/characters?id=eq.$id')).timeout(defaultTimeout);
  }

  // will return only "family_id" field
  Future<dynamic> getCharactersFamilyId() async {
    return await http.get(Uri.parse('$_baseUrl/characters?select=family_id')).timeout(defaultTimeout);
  }

  Future<dynamic> getAllFamilies() async { 
    return await http.get(Uri.parse('$_baseUrl/families')).timeout(defaultTimeout);
  }

  Future<dynamic> getFamilyById(int id) async {
    return await http.get(Uri.parse('$_baseUrl/families?id=eq.$id')).timeout(defaultTimeout);
  }

  // returns all charcters by a family Id
  Future<dynamic> getCharactersByFamilyId(int familyId) async {
    return await http.get(Uri.parse('$_baseUrl/characters?family_id=eq.$familyId')).timeout(defaultTimeout);
  }


}