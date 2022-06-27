import 'package:http/http.dart' as http;

/*
 This class will only have the responsability to send and recieve
 request from the external api
*/

class ApiService {

  static const String _baseUrl = "https://thronesapi.com/api/v2";

  // generic get method
  Future<dynamic> getAllCharacters() async {
    // should be inside a try/catch block in case errors occurs when reaching the API
    http.Response response =  await http.get(Uri.parse(_baseUrl + '/characters'));
    return response;    
  }

  Future<dynamic> getCharacterById(int id) async {
    return await http.get(Uri.parse(_baseUrl + '/characters/$id'));
  }

}