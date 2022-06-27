import 'dart:convert';

Character characterFromJson(String str) => Character.fromJson(json.decode(str));
String characterToJson(Character data) => json.encode(data.toJson());

class Character {
  Character({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.title,
    required this.family,
    required this.imageUrl,
  });
  int id;
  String firstName;
  String lastName;
  String fullName;
  String title;
  String family;
  String imageUrl;
  
  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        title: json["title"],
        family: json["family"],
        imageUrl: json["imageUrl"],
      );

      
  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "title": title,
        "family": family,
        "imageUrl": imageUrl,
      };
}
